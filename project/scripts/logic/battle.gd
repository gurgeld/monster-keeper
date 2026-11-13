## Simulated 1v1 battle (vault/Batalha.md). Pure: same fighters and seed give
## the same result and log. Has no access to Game.
class_name Battle
extends RefCounted

enum Strategy { BALANCED, ATTACK, GUARD }


## One fighter's state during the fight.
class FighterState:
	var fighter: Fighter
	var max_life: int
	var life: int
	var gauge := 0.0
	## Own turns so far, skipped turns included (they count for cooldown).
	var turns := 0
	## Skill index -> first own turn when it is ready again.
	var ready_at := {}
	## Strategy effect until the next own turn.
	var damage_factor := 1.0
	var defense_factor := 1.0
	var guarding := false


class Result:
	## 0 = first fighter, 1 = second fighter.
	var winner: int
	## Life left in %, one value per fighter.
	var life_percent: Array[float] = []
	var max_life: Array[int] = []
	## Turns of both fighters, skipped turns included.
	var actions: int
	var ticks: int
	var timed_out: bool
	## One Dictionary per event. Keys: tick, actor, kind
	## ("ignore_strategy", "skip", "miss", "hit"), and for miss and hit: skill;
	## for hit: damage, multiplier, life (Array of both fighters' life).
	var events: Array[Dictionary] = []


static func fight(a: Fighter, b: Fighter, seed_value: int, rules: BattleRules) -> Result:
	var rng := RandomNumberGenerator.new()
	rng.seed = seed_value
	var states: Array[FighterState] = [_start(a, rules), _start(b, rules)]
	var result := Result.new()
	var ended := false
	var tick := 0
	while tick < rules.tick_limit and not ended:
		tick += 1
		for state: FighterState in states:
			state.gauge += rules.gauge_per_tick + state.fighter.stats[Monster.Stat.SPEED] * rules.gauge_per_speed
		var order: Array[int] = [0, 1]
		var both_ready := states[0].gauge >= rules.gauge_full and states[1].gauge >= rules.gauge_full
		if states[1].gauge > states[0].gauge or (both_ready and states[0].gauge == states[1].gauge and rng.randf() < 0.5):
			order = [1, 0]
		for i: int in order:
			var me := states[i]
			if me.gauge < rules.gauge_full or ended:
				continue
			me.gauge -= rules.gauge_full
			_take_turn(i, me, states[1 - i], tick, rng, rules, result.events, states)
			ended = states[1 - i].life <= 0

	for state: FighterState in states:
		result.life_percent.append(100.0 * state.life / state.max_life)
		result.max_life.append(state.max_life)
	result.winner = 0 if result.life_percent[0] > result.life_percent[1] else 1
	if result.life_percent[0] == result.life_percent[1]:
		result.winner = 0 if rng.randf() < 0.5 else 1
	result.actions = states[0].turns + states[1].turns
	result.ticks = tick
	result.timed_out = not ended
	return result


static func _start(fighter: Fighter, rules: BattleRules) -> FighterState:
	var state := FighterState.new()
	state.fighter = fighter
	state.max_life = fighter.stats[Monster.Stat.LIFE] + rules.life_bonus
	state.life = state.max_life
	return state


static func _take_turn(index: int, me: FighterState, foe: FighterState, tick: int,
		rng: RandomNumberGenerator, rules: BattleRules, events: Array[Dictionary],
		states: Array[FighterState]) -> void:
	me.turns += 1
	var obedience := me.fighter.obedience

	# 1. Follows the strategy? The result holds until the next own turn.
	me.damage_factor = 1.0
	me.defense_factor = 1.0
	me.guarding = false
	if me.fighter.strategy != Strategy.BALANCED:
		if rng.randf() * 100.0 < obedience:
			if me.fighter.strategy == Strategy.ATTACK:
				me.damage_factor = rules.attack_damage
				me.defense_factor = rules.attack_defense
			else:
				me.damage_factor = rules.guard_damage
				me.guarding = true
		else:
			events.append({"tick": tick, "actor": index, "kind": "ignore_strategy"})

	# 2. Skips the action? The turn still counts for cooldown.
	if obedience < rules.skip_threshold:
		var skip_chance := minf(rules.skip_max, (rules.skip_threshold - obedience) / rules.skip_divisor)
		if rng.randf() * 100.0 < skip_chance:
			events.append({"tick": tick, "actor": index, "kind": "skip"})
			return

	var skill_index := _choose_skill(me, foe, rng, rules)
	var skill := me.fighter.breed.skills[skill_index]
	if skill.cooldown > 0:
		me.ready_at[skill_index] = me.turns + skill.cooldown + 1

	var precision: float = me.fighter.stats[Monster.Stat.SKILL]
	var foe_speed: float = foe.fighter.stats[Monster.Stat.SPEED]
	var hit_chance := clampf(
		rules.hit_base + rules.hit_slope * (precision - foe_speed) / (precision + foe_speed),
		rules.hit_min, rules.hit_max)
	if rng.randf() >= hit_chance:
		events.append({"tick": tick, "actor": index, "kind": "miss", "skill": skill.name})
		return

	var scale: float = me.fighter.stats[skill.scale_stat]
	var defense: float = foe.fighter.stats[Monster.Stat.DEFENSE] * foe.defense_factor
	var multiplier := _type_multiplier(skill.damage_type, foe.fighter.breed, rules)
	if multiplier > 1.0 and foe.guarding:
		multiplier = 1.0
	var variation := 1.0 - rules.damage_variation + 2.0 * rules.damage_variation * rng.randf()
	var damage := maxi(1, roundi(scale * skill.power / 100.0 * scale / (scale + rules.defense_weight * defense)
		* multiplier * rules.damage_scale * me.damage_factor * variation))
	foe.life = maxi(0, foe.life - damage)
	events.append({"tick": tick, "actor": index, "kind": "hit", "skill": skill.name,
		"damage": damage, "multiplier": multiplier, "life": [states[0].life, states[1].life]})


## Weighted draw among ready skills. With chance Int ÷ (Int + offset), only the
## ready skills with the best type against the target enter the draw.
## Returns the skill index in the breed.
static func _choose_skill(me: FighterState, foe: FighterState, rng: RandomNumberGenerator,
		rules: BattleRules) -> int:
	var skills := me.fighter.breed.skills
	var pool: Array[int] = []
	for i: int in me.fighter.unlocked_skills:
		if me.ready_at.get(i, 0) <= me.turns:
			pool.append(i)
	var intelligence: float = me.fighter.stats[Monster.Stat.INTELLIGENCE]
	if rng.randf() < intelligence / (intelligence + rules.smart_choice_offset):
		var best := 0.0
		for i: int in pool:
			best = maxf(best, _type_multiplier(skills[i].damage_type, foe.fighter.breed, rules))
		var best_pool: Array[int] = []
		for i: int in pool:
			if _type_multiplier(skills[i].damage_type, foe.fighter.breed, rules) == best:
				best_pool.append(i)
		pool = best_pool
	var total := 0.0
	for i: int in pool:
		total += skills[i].weight
	var roll := rng.randf() * total
	for i: int in pool:
		roll -= skills[i].weight
		if roll <= 0.0:
			return i
	return pool[-1]


static func _type_multiplier(damage_type: BattleSkill.DamageType, target: Breed, rules: BattleRules) -> float:
	if damage_type == target.weakness:
		return rules.weakness_multiplier
	if damage_type == target.resistance:
		return rules.resistance_multiplier
	return 1.0

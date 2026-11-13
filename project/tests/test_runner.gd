# Run with: godot --headless --path project --script res://tests/test_runner.gd
extends SceneTree

const BREED_PATHS: Array[String] = [
	"res://data/breeds/tatuco.tres",
	"res://data/breeds/vulpi.tres",
	"res://data/breeds/runoxa.tres",
]
const SEEDS_TO_CHECK := 200
const EPSILON := 0.0001

var passed := 0
var failed := 0


func _initialize() -> void:
	var tests: Array[String] = [
		"test_breeds_follow_balance_rules",
		"test_parents_alleles_vary_within_10_percent",
		"test_same_egg_seed_gives_same_egg_and_monster",
		"test_child_gets_one_allele_from_each_parent",
		"test_initial_stats_vary_within_10_percent",
		"test_egg_price_follows_quality",
		"test_word_validation",
		"test_same_word_gives_same_effect",
		"test_word_depends_on_save_seed",
		"test_word_effect_rules",
		"test_word_sum_distribution",
		"test_shop_and_purchase",
		"test_incubation_takes_4_weeks",
		"test_training_gain_uses_growth_rate",
		"test_fatigue_reduces_gain",
		"test_fatigue_stays_between_0_and_100",
		"test_stats_cap_at_999",
		"test_game_ends_after_52_weeks",
		"test_grade_letters",
		"test_breed_battle_data_follows_rules",
		"test_same_fight_seed_gives_same_result_and_log",
		"test_battle_life_is_stat_plus_90",
		"test_type_multipliers",
		"test_guard_cancels_weakness",
		"test_skipped_action_counts_for_cooldown",
		"test_battle_stops_at_600_ticks",
		"test_10_percent_stronger_wins_mirror",
		"test_favored_breed_wins_with_equal_training",
		"test_most_fights_last_9_to_30_actions",
	]
	for t: String in tests:
		if call(t) != true:
			failed += 1
			push_error("FAIL %s: did not finish (runtime error?)" % t)
	print("Results: %d passed, %d failed" % [passed, failed])
	quit(1 if failed > 0 else 0)


func check(condition: bool, label: String) -> void:
	if condition:
		passed += 1
	else:
		failed += 1
		push_error("FAIL " + label)


func load_breeds() -> Array[Breed]:
	var breeds: Array[Breed] = []
	for path: String in BREED_PATHS:
		breeds.append(load(path) as Breed)
	return breeds


func is_within(value: float, base: float, variation: float) -> bool:
	return value >= base * (1.0 - variation) - EPSILON and value <= base * (1.0 + variation) + EPSILON


# --- Breeds (vault/Raças.md) ---

func test_breeds_follow_balance_rules() -> bool:
	for breed: Breed in load_breeds():
		check(breed.growth_rates.size() == Monster.STAT_COUNT, "%s has 6 growth rates" % breed.name)
		check(breed.initial_stats.size() == Monster.STAT_COUNT, "%s has 6 initial stats" % breed.name)
		var rate_sum := 0.0
		for rate: float in breed.growth_rates:
			rate_sum += rate
		var stat_sum := 0
		for stat: int in breed.initial_stats:
			stat_sum += stat
		check(is_equal_approx(rate_sum, 6.0), "%s growth rates sum to 6.0 (got %s)" % [breed.name, rate_sum])
		check(stat_sum == 300, "%s initial stats sum to 300 (got %s)" % [breed.name, stat_sum])
	return true


# --- Eggs and genetics (vault/Ovo.md, vault/Procriação.md) ---

func test_parents_alleles_vary_within_10_percent() -> bool:
	for breed: Breed in load_breeds():
		var all_ok := true
		for seed_value in SEEDS_TO_CHECK:
			var egg := Egg.from_random_parents(breed, seed_value)
			for parent: Monster in [egg.father, egg.mother]:
				for i in Monster.STAT_COUNT:
					var base: float = breed.growth_rates[i]
					var a: float = parent.alleles_a[i]
					var b: float = parent.alleles_b[i]
					if not is_within(a, base, 0.1) or not is_within(b, base, 0.1):
						all_ok = false
					if absf(parent.growth_rates[i] - (a + b) / 2.0) > EPSILON:
						all_ok = false
		check(all_ok, "%s parent alleles stay within base ±10%% and rate is their mean" % breed.name)
	return true


func test_same_egg_seed_gives_same_egg_and_monster() -> bool:
	var breed: Breed = load_breeds()[0]
	var effect := WordEffect.from_word("fogo", 99)
	var egg_a := Egg.from_random_parents(breed, 12345)
	var egg_b := Egg.from_random_parents(breed, 12345)
	check(egg_a.father.alleles_a == egg_b.father.alleles_a, "same seed, same father")
	check(egg_a.price == egg_b.price, "same seed, same price")
	var child_a := egg_a.hatch(effect)
	var child_b := egg_b.hatch(effect)
	check(child_a.breed == breed, "child keeps the egg breed")
	check(child_a.growth_rates == child_b.growth_rates, "same seed, same child growth rates")
	check(child_a.stats == child_b.stats, "same seed, same child stats")
	check(Egg.from_random_parents(breed, 1).father.alleles_a
		!= Egg.from_random_parents(breed, 2).father.alleles_a, "different seeds, different parents")
	return true


func test_child_gets_one_allele_from_each_parent() -> bool:
	var breed: Breed = load_breeds()[1]
	var effect := WordEffect.from_word("vento", 7)
	var all_ok := true
	for seed_value in SEEDS_TO_CHECK:
		var egg := Egg.from_random_parents(breed, seed_value)
		var child := egg.hatch(effect)
		for i in Monster.STAT_COUNT:
			var from_father: Array[float] = [egg.father.alleles_a[i], egg.father.alleles_b[i]]
			var from_mother: Array[float] = [egg.mother.alleles_a[i], egg.mother.alleles_b[i]]
			if not (child.alleles_a[i] in from_father and child.alleles_b[i] in from_mother):
				all_ok = false
			var expected := (child.alleles_a[i] + child.alleles_b[i]) / 2.0 + effect.modifier(i)
			if absf(child.growth_rates[i] - expected) > EPSILON:
				all_ok = false
	check(all_ok, "child alleles come from parents; rate = allele mean + word modifier")
	return true


func test_initial_stats_vary_within_10_percent() -> bool:
	var effect := WordEffect.from_word("terra", 1)
	for breed: Breed in load_breeds():
		var all_ok := true
		for seed_value in SEEDS_TO_CHECK:
			var monster := Egg.from_random_parents(breed, seed_value).hatch(effect)
			for i in Monster.STAT_COUNT:
				var base: int = breed.initial_stats[i]
				var stat: int = monster.stats[i]
				if stat < roundi(base * 0.9) or stat > roundi(base * 1.1):
					all_ok = false
		check(all_ok, "%s initial stats stay within base ±10%%" % breed.name)
	return true


func test_egg_price_follows_quality() -> bool:
	check(Egg.price_for_quality(6.0) == 650, "quality 6.0 costs 650")
	check(Egg.price_for_quality(6.1) == 780, "quality 6.1 costs 780 (775 rounded to tens)")
	check(Egg.price_for_quality(5.8) == 400, "quality 5.8 costs 400")
	check(Egg.price_for_quality(5.0) == 400, "price never goes below 400")
	check(Egg.price_for_quality(7.0) == 900, "price never goes above 900")
	var egg := Egg.from_random_parents(load_breeds()[2], 5)
	check(egg.price == Egg.price_for_quality(egg.expected_quality()), "egg price uses its quality")
	return true


# --- Word (vault/Palavra.md) ---

func test_word_validation() -> bool:
	check(not WordEffect.is_valid("ab"), "2 letters is too short")
	check(WordEffect.is_valid("abc"), "3 letters is valid")
	check(WordEffect.is_valid("abcdefg"), "7 letters is valid")
	check(not WordEffect.is_valid("abcdefgh"), "8 letters is too long")
	check(not WordEffect.is_valid("ab1"), "digits are not letters")
	check(not WordEffect.is_valid("a b c"), "spaces are not letters")
	check(WordEffect.is_valid("Ação"), "accented letters are valid")
	return true


func test_same_word_gives_same_effect() -> bool:
	var a := WordEffect.from_word("fogo", 42)
	var b := WordEffect.from_word("FOGO", 42)
	check(a.plus_stat == b.plus_stat and a.plus_points == b.plus_points
		and a.minus_stat == b.minus_stat and a.minus_points == b.minus_points,
		"same word in the same save gives the same effect, ignoring case")
	return true


func test_word_depends_on_save_seed() -> bool:
	var differs := false
	for word: String in ["fogo", "agua", "terra", "vento", "luz"]:
		var a := WordEffect.from_word(word, 1)
		var b := WordEffect.from_word(word, 2)
		if a.plus_stat != b.plus_stat or a.minus_stat != b.minus_stat:
			differs = true
	check(differs, "the same word gives other effects in another save")
	return true


func make_words(count: int) -> Array[String]:
	var rng := RandomNumberGenerator.new()
	rng.seed = 2024
	var words: Array[String] = []
	for i in count:
		var word := ""
		for j in rng.randi_range(3, 7):
			word += char(rng.randi_range(97, 122))
		words.append(word)
	return words


func test_word_effect_rules() -> bool:
	var all_ok := true
	for word: String in make_words(500):
		var e := WordEffect.from_word(word, 77)
		var total := e.plus_points - e.minus_points
		if e.plus_stat == e.minus_stat:
			all_ok = false
		if e.minus_points < 1 or e.minus_points > 3:
			all_ok = false
		if total < 0 or total > 3 or e.plus_points > 4:
			all_ok = false
		if absf(e.modifier(e.plus_stat) - e.plus_points * 0.05) > EPSILON:
			all_ok = false
		if absf(e.modifier(e.minus_stat) + e.minus_points * 0.05) > EPSILON:
			all_ok = false
	check(all_ok, "every word: 2 different stats, minus 1-3, sum 0-3, plus up to 4, 1 point = 0.05")
	return true


func test_word_sum_distribution() -> bool:
	var counts: Array[int] = [0, 0, 0, 0]
	var words := make_words(4000)
	for word: String in words:
		var e := WordEffect.from_word(word, 77)
		counts[e.plus_points - e.minus_points] += 1
	var zero_share := counts[0] / float(words.size())
	check(zero_share > 0.76 and zero_share < 0.84, "about 80%% of words sum to 0 (got %.3f)" % zero_share)
	check(counts[1] > counts[2] and counts[2] > counts[3], "better sums are rarer (%s)" % [counts])
	check(counts[3] > 0, "sum +3 exists")
	return true


# --- Game flow (vault/Protótipo jogável.md) ---

func test_shop_and_purchase() -> bool:
	var game := Game.new(555, load_breeds())
	check(game.money == 1000, "game starts with 1000")
	check(game.shop.size() == 5, "shop has 5 eggs")
	var all_prices_ok := true
	for egg: Egg in game.shop:
		if egg.price < 400 or egg.price > 900 or egg.price % 10 != 0:
			all_prices_ok = false
	check(all_prices_ok, "shop prices are 400-900, in tens")
	var price := game.shop[2].price
	game.buy(2)
	check(game.money == 1000 - price, "buying pays the egg price")
	check(game.egg == game.shop[2], "bought egg is kept")
	return true


func start_incubation(game_seed: int) -> Game:
	var game := Game.new(game_seed, load_breeds())
	game.buy(0)
	game.start_incubation("fogo")
	return game


func test_incubation_takes_4_weeks() -> bool:
	var game := start_incubation(1)
	check(game.week == 1 and game.monster == null, "incubation starts at week 1 with no monster")
	for i in 3:
		game.wait_week()
	check(game.week == 4 and game.monster == null, "no monster after 3 weeks")
	game.wait_week()
	check(game.week == 5 and game.monster != null, "monster hatches at week 5")
	check(game.monster.breed == game.egg.breed, "monster has the egg breed")
	return true


# --- Training (vault/Treino semanal.md) ---

# A monster with known values, so the expected numbers are easy to compute.
func make_test_monster() -> Monster:
	var monster := Monster.new()
	monster.growth_rates.assign([1.0, 1.5, 0.5, 1.0, 1.0, 1.0])
	monster.stats.assign([100, 100, 100, 100, 100, 100])
	return monster


func test_training_gain_uses_growth_rate() -> bool:
	var monster := make_test_monster()
	check(monster.train(Monster.Stat.POWER) == 15, "gain = 10 × 1.5 with no fatigue")
	check(monster.stats[Monster.Stat.POWER] == 115, "POWER goes from 100 to 115")
	check(monster.stats[Monster.Stat.LIFE] == 100, "training POWER does not change LIFE")
	return true


func test_fatigue_reduces_gain() -> bool:
	var monster := make_test_monster()
	monster.train(Monster.Stat.LIFE)
	check(monster.fatigue == 20, "one training adds 20 fatigue")
	check(monster.train(Monster.Stat.LIFE) == 9, "fatigue 20 gives gain 10 × 0.9")
	monster.fatigue = 100
	check(monster.train(Monster.Stat.LIFE) == 5, "fatigue 100 gives gain 10 × 0.5")
	monster.rest()
	check(monster.fatigue == 60, "rest removes 40 fatigue")
	return true


func test_fatigue_stays_between_0_and_100() -> bool:
	var monster := make_test_monster()
	for i in 10:
		monster.train(Monster.Stat.LIFE)
	check(monster.fatigue == 100, "fatigue stops at 100")
	for i in 5:
		monster.rest()
	check(monster.fatigue == 0, "fatigue stops at 0")
	return true


func test_stats_cap_at_999() -> bool:
	var monster := make_test_monster()
	monster.stats[Monster.Stat.LIFE] = 995
	monster.train(Monster.Stat.LIFE)
	check(monster.stats[Monster.Stat.LIFE] == 999, "stat stops at 999")
	return true


func test_game_ends_after_52_weeks() -> bool:
	var game := start_incubation(3)
	for i in 4:
		game.wait_week()
	for i in 47:
		if i % 2 == 0:
			game.train(Monster.Stat.LIFE)
		else:
			game.rest()
	check(game.week == 52 and not game.is_over(), "week 52 is still playable")
	game.rest()
	check(game.is_over(), "game is over after week 52")
	return true


func test_grade_letters() -> bool:
	check(Monster.grade(0.5) == "E", "0.5 is E")
	check(Monster.grade(0.7) == "D", "0.7 is D")
	check(Monster.grade(1.0) == "C", "1.0 is C")
	check(Monster.grade(1.1) == "B", "1.1 is B")
	check(Monster.grade(1.3) == "A", "1.3 is A")
	check(Monster.grade(1.54) == "A", "above 1.5 shows A for now")
	return true


# --- Battle (vault/Batalha.md) ---

const BATTLE_RULES_PATH := "res://data/battle_rules.tres"


## A fighter after some weeks of training split evenly (vault/Batalha.md, "Números da luta").
func make_fighter(breed: Breed, weeks: float, multiplier := 1.0,
		strategy: Battle.Strategy = Battle.Strategy.BALANCED, obedience := 100) -> Fighter:
	var stats: Array[int] = []
	for i in Monster.STAT_COUNT:
		var value: float = (breed.initial_stats[i] + breed.growth_rates[i] * weeks) * multiplier
		stats.append(mini(roundi(value), Monster.MAX_STAT))
	return Fighter.create(breed, stats, breed.skills_unlocked_by(stats), obedience, strategy)


func test_breed_battle_data_follows_rules() -> bool:
	for breed: Breed in load_breeds():
		check(breed.skills.size() == 4, "%s has 4 skills" % breed.name)
		var types := [breed.resistance, breed.neutral, breed.weakness]
		check(types.has(BattleSkill.DamageType.CUTTING) and types.has(BattleSkill.DamageType.PIERCING)
			and types.has(BattleSkill.DamageType.IMPACT), "%s has 1 resistance, 1 neutral, 1 weakness" % breed.name)
		check(breed.secondary_type == breed.weakness, "%s secondary type is its own weakness" % breed.name)
		var expected_types := [breed.primary_type, breed.primary_type, breed.secondary_type, breed.primary_type]
		var all_ok := true
		for i in breed.skills.size():
			if breed.skills[i].damage_type != expected_types[i]:
				all_ok = false
		check(all_ok, "%s skills use primary, primary, secondary, primary" % breed.name)
		check(breed.skills[0].cooldown == 0 and breed.skills[0].unlock_min == 0, "%s basic skill is free" % breed.name)
		check(breed.skills[2].scale_stat == Monster.Stat.POWER, "%s cover skill scales with Força" % breed.name)
		check(breed.skills[3].scale_stat == Monster.Stat.SKILL, "%s precise skill scales with Precisão" % breed.name)
	return true


func test_same_fight_seed_gives_same_result_and_log() -> bool:
	var rules := battle_rules()
	var breeds := load_breeds()
	var a := make_fighter(breeds[0], 50, 1.0, Battle.Strategy.ATTACK, 30)
	var b := make_fighter(breeds[2], 50)
	var first := Battle.fight(a, b, 777, rules)
	var second := Battle.fight(a, b, 777, rules)
	check(first.winner == second.winner, "same seed, same winner")
	check(first.life_percent == second.life_percent, "same seed, same life left")
	check(first.actions == second.actions, "same seed, same number of actions")
	check(first.events == second.events and first.events.size() > 0, "same seed, same log")
	var differs := false
	for seed_value in range(1, 20):
		if Battle.fight(a, b, seed_value, rules).events != first.events:
			differs = true
	check(differs, "other seeds give other fights")
	return true


func battle_rules() -> BattleRules:
	return load(BATTLE_RULES_PATH)


func fighter_with_stats(breed: Breed, stats: Array[int],
		strategy: Battle.Strategy = Battle.Strategy.BALANCED, obedience := 100) -> Fighter:
	var all_skills: Array[int] = []
	for i in breed.skills.size():
		all_skills.append(i)
	return Fighter.create(breed, stats, all_skills, obedience, strategy)


func test_battle_life_is_stat_plus_90() -> bool:
	var breeds := load_breeds()
	var stats: Array[int] = [100, 60, 20, 60, 40, 80]
	var result := Battle.fight(fighter_with_stats(breeds[0], stats), make_fighter(breeds[1], 0), 3, battle_rules())
	check(result.max_life[0] == 190, "Life 100 gives 190 in battle (got %d)" % result.max_life[0])
	check(result.max_life[1] == 135, "Vulpi base Life 45 gives 135 in battle (got %d)" % result.max_life[1])
	return true


## Skill name -> set of multipliers seen in hits by the first fighter.
func multipliers_seen(attacker: Fighter, target: Fighter, after_target_acts := false) -> Dictionary:
	var seen := {}
	for seed_value in 30:
		var target_acted := false
		for entry: Dictionary in Battle.fight(attacker, target, seed_value, battle_rules()).events:
			if entry.actor == 1:
				target_acted = true
			elif entry.kind == "hit" and (target_acted or not after_target_acts):
				if not seen.has(entry.skill):
					seen[entry.skill] = {}
				seen[entry.skill][entry.multiplier] = true
	return seen


func test_type_multipliers() -> bool:
	var breeds := load_breeds()
	var tatuco := make_fighter(breeds[0], 100)
	# Tatuço uses cutting (Garrada, Rolo blindado, Lâmina de placa) and impact (Cabeçada).
	var against_runoxa := multipliers_seen(tatuco, make_fighter(breeds[2], 100))
	check(against_runoxa.get("Garrada", {}).keys() == [1.5], "cutting on Runoxa is weakness ×1.5")
	check(against_runoxa.get("Cabeçada", {}).keys() == [1.0], "impact on Runoxa is neutral ×1.0")
	var mirror := multipliers_seen(tatuco, make_fighter(breeds[0], 100))
	check(mirror.get("Garrada", {}).keys() == [0.5], "cutting on Tatuço is resisted ×0.5")
	check(mirror.get("Cabeçada", {}).keys() == [1.5], "impact on Tatuço is weakness ×1.5")
	return true


func test_guard_cancels_weakness() -> bool:
	var breeds := load_breeds()
	var tatuco := make_fighter(breeds[0], 100)
	var guarding := make_fighter(breeds[0], 100, 1.0, Battle.Strategy.GUARD)
	var seen := multipliers_seen(tatuco, guarding, true)
	check(seen.get("Cabeçada", {}).keys() == [1.0], "Guard turns weakness ×1.5 into ×1.0")
	check(seen.get("Garrada", {}).keys() == [0.5], "Guard keeps resistance ×0.5")
	return true


## A breed with one basic skill that is almost never drawn and one strong skill
## with cooldown 1 that is drawn whenever it is ready.
func make_cooldown_breed() -> Breed:
	var breed := Breed.new()
	breed.name = "Test"
	var basic := BattleSkill.new()
	basic.name = "basic"
	basic.weight = 0.000001
	basic.power = 10
	var strong := BattleSkill.new()
	strong.name = "strong"
	strong.cooldown = 1
	strong.weight = 1000000
	strong.power = 10
	breed.skills.assign([basic, strong])
	return breed


func test_skipped_action_counts_for_cooldown() -> bool:
	var breed := make_cooldown_breed()
	var stats: Array[int] = [999, 50, 0, 999, 50, 999]
	var disobedient := fighter_with_stats(breed, stats, Battle.Strategy.BALANCED, 0)
	var target := fighter_with_stats(breed, stats)
	var turns: Array[String] = []
	for seed_value in 20:
		for entry: Dictionary in Battle.fight(disobedient, target, seed_value, battle_rules()).events:
			if entry.actor == 0:
				turns.append("skip" if entry.kind == "skip" else entry.skill)
		turns.append("end")
	var strong_after_skip := false
	var strong_twice := false
	for i in turns.size() - 2:
		if turns[i] == "strong" and turns[i + 1] == "skip" and turns[i + 2] == "strong":
			strong_after_skip = true
		if turns[i] == "strong" and turns[i + 1] == "strong":
			strong_twice = true
	check(strong_after_skip, "strong skill is ready again right after a skipped turn")
	check(not strong_twice, "cooldown 1 still blocks the next turn")
	var skip_share := turns.count("skip") / float(turns.size() - turns.count("end"))
	check(skip_share > 0.2 and skip_share < 0.3, "obedience 0 skips about 25%% (got %.3f)" % skip_share)
	return true


func test_battle_stops_at_600_ticks() -> bool:
	# Both skills scale with Força 1: every hit does 1 damage, so nobody falls.
	var breed := make_cooldown_breed()
	var wall: Array[int] = [999, 1, 0, 999, 0, 999]
	var weaker_wall: Array[int] = [900, 1, 0, 999, 0, 999]
	var result := Battle.fight(fighter_with_stats(breed, wall), fighter_with_stats(breed, weaker_wall),
		5, battle_rules())
	check(result.timed_out and result.ticks == 600, "fight stops at the 600 tick limit")
	var expected := 0 if result.life_percent[0] > result.life_percent[1] else 1
	check(result.winner == expected, "at the limit, the higher Life %% wins")
	return true


func win_share(a: Fighter, b: Fighter, fights: int) -> float:
	var wins := 0
	for seed_value in fights:
		if Battle.fight(a, b, seed_value, battle_rules()).winner == 0:
			wins += 1
	return wins / float(fights)


# Statistical tests use fixed seeds and wide margins. Reference numbers:
# vault/Batalha.md, "Por quê sem sistema de sorte" and "Por quê manter ×1,5 e ×0,5".
func test_10_percent_stronger_wins_mirror() -> bool:
	for breed: Breed in load_breeds():
		var share := win_share(make_fighter(breed, 50, 1.1), make_fighter(breed, 50), 200)
		check(share > 0.7, "%s with +10%% wins the mirror (got %.2f)" % [breed.name, share])
	return true


func test_favored_breed_wins_with_equal_training() -> bool:
	var breeds := load_breeds()
	# Tatuço > Runoxa > Vulpi > Tatuço (vault/Raças.md).
	for pair: Array[int] in [[0, 2], [2, 1], [1, 0]] as Array[Array]:
		var winner := breeds[pair[0]]
		var loser := breeds[pair[1]]
		var share := win_share(make_fighter(winner, 50), make_fighter(loser, 50), 200)
		check(share > 0.7, "%s beats %s (got %.2f)" % [winner.name, loser.name, share])
	return true


func test_most_fights_last_9_to_30_actions() -> bool:
	var inside := 0
	var total := 0
	for a: Breed in load_breeds():
		for b: Breed in load_breeds():
			for weeks: int in [50, 100]:
				for seed_value in 50:
					var actions := Battle.fight(make_fighter(a, weeks), make_fighter(b, weeks),
						seed_value, battle_rules()).actions
					total += 1
					if actions >= 9 and actions <= 30:
						inside += 1
	var share := inside / float(total)
	check(share > 0.6, "most fights last 9 to 30 actions (got %.2f)" % share)
	return true

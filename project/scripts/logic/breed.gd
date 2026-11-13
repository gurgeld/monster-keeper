## Design data for a breed. Values come from vault/Raças.md.
## Arrays follow the order of Monster.Stat.
class_name Breed
extends Resource

@export var name: String = ""
@export var growth_rates: Array[float] = []
@export var initial_stats: Array[int] = []

@export_group("Battle")
@export var resistance: BattleSkill.DamageType = BattleSkill.DamageType.CUTTING
@export var neutral: BattleSkill.DamageType = BattleSkill.DamageType.PIERCING
@export var weakness: BattleSkill.DamageType = BattleSkill.DamageType.IMPACT
@export var primary_type: BattleSkill.DamageType = BattleSkill.DamageType.CUTTING
@export var secondary_type: BattleSkill.DamageType = BattleSkill.DamageType.IMPACT
## 4 skills in position order: basic, strong, cover, precise.
@export var skills: Array[BattleSkill] = []


## Indexes of the skills whose unlock minimum the stats reach.
func skills_unlocked_by(stats: Array[int]) -> Array[int]:
	var unlocked: Array[int] = []
	for i in skills.size():
		if stats[skills[i].scale_stat] >= skills[i].unlock_min:
			unlocked.append(i)
	return unlocked

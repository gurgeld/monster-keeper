## Design data for one battle skill of a breed. Values come from vault/Raças.md.
class_name BattleSkill
extends Resource

enum DamageType { CUTTING, PIERCING, IMPACT }

@export var name: String = ""
@export var damage_type: DamageType = DamageType.CUTTING
## The stat that scales the damage. The same stat unlocks the skill.
@export var scale_stat: Monster.Stat = Monster.Stat.POWER
## Own actions to wait after use. 0 = always ready.
@export var cooldown: int = 0
@export var weight: float = 1.0
@export var power: float = 0.0
## Minimum value of scale_stat to unlock the skill. 0 = unlocked at birth.
@export var unlock_min: int = 0

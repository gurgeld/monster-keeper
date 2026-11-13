## Battle constants. The values live only in data/battle_rules.tres.
## They come from vault/Batalha.md ("Números da luta", "Estratégia e
## obediência") and vault/Raças.md (type multipliers).
class_name BattleRules
extends Resource

@export var gauge_full: float
@export var gauge_per_tick: float
@export var gauge_per_speed: float
@export var tick_limit: int
@export var life_bonus: int

@export var hit_base: float
@export var hit_slope: float
@export var hit_min: float
@export var hit_max: float

@export var damage_scale: float
@export var defense_weight: float
## Damage varies by ± this fraction.
@export var damage_variation: float
@export var weakness_multiplier: float
@export var resistance_multiplier: float

@export var attack_damage: float
@export var attack_defense: float
@export var guard_damage: float

## Chance to choose the best type is Intelligence ÷ (Intelligence + this).
@export var smart_choice_offset: float
## Below this obedience the monster can skip its action.
@export var skip_threshold: int
## Skip chance in % is (skip_threshold − obedience) ÷ skip_divisor, up to skip_max.
@export var skip_divisor: float
@export var skip_max: float

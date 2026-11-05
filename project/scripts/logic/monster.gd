## A monster: its breed, its own growth rates and its current stats.
class_name Monster
extends Resource

enum Stat { LIFE, POWER, INTELLIGENCE, SKILL, SPEED, DEFENSE }
const STAT_COUNT := 6
## Each egg rolls a variation of ±10% over the breed base (vault/Stats.md).
const EGG_VARIATION := 0.1
## Training rules (vault/Treino semanal.md).
const TRAINING_BASE_GAIN := 10.0
const FATIGUE_PER_TRAINING := 20
const FATIGUE_RECOVERED_BY_REST := 40
const MAX_FATIGUE := 100
const MAX_STAT := 999

@export var breed: Breed
@export var growth_rates: Array[float] = []
@export var stats: Array[int] = []
@export var fatigue: int = 0


## Creates a newborn monster. The same breed and seed always give the same monster.
static func hatch(from_breed: Breed, seed_value: int) -> Monster:
	var rng := RandomNumberGenerator.new()
	rng.seed = seed_value
	var monster := Monster.new()
	monster.breed = from_breed
	for i in STAT_COUNT:
		monster.growth_rates.append(from_breed.growth_rates[i] * _roll_variation(rng))
	for i in STAT_COUNT:
		monster.stats.append(roundi(from_breed.initial_stats[i] * _roll_variation(rng)))
	return monster


## Trains one stat and returns how much it went up.
func train(stat: Stat) -> int:
	var fatigue_factor := 1.0 - fatigue / 200.0
	var gain := roundi(TRAINING_BASE_GAIN * growth_rates[stat] * fatigue_factor)
	var old_value := stats[stat]
	stats[stat] = mini(old_value + gain, MAX_STAT)
	fatigue = mini(fatigue + FATIGUE_PER_TRAINING, MAX_FATIGUE)
	return stats[stat] - old_value


func rest() -> void:
	fatigue = maxi(fatigue - FATIGUE_RECOVERED_BY_REST, 0)


## Letter shown to the player for a growth rate (vault/Stats.md).
static func grade(rate: float) -> String:
	if rate < 0.7:
		return "E"
	if rate < 0.9:
		return "D"
	if rate < 1.1:
		return "C"
	if rate < 1.3:
		return "B"
	return "A"


static func _roll_variation(rng: RandomNumberGenerator) -> float:
	return rng.randf_range(1.0 - EGG_VARIATION, 1.0 + EGG_VARIATION)

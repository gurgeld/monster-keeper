## A monster: its breed, its own growth rates and its current stats.
class_name Monster
extends Resource

enum Stat { LIFE, POWER, INTELLIGENCE, SKILL, SPEED, DEFENSE }
const STAT_COUNT := 6
## Each egg rolls a variation of ±10% over the breed base (vault/Stats.md).
const EGG_VARIATION := 0.1

@export var breed: Breed
@export var growth_rates: Array[float] = []
@export var stats: Array[int] = []


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


static func _roll_variation(rng: RandomNumberGenerator) -> float:
	return rng.randf_range(1.0 - EGG_VARIATION, 1.0 + EGG_VARIATION)

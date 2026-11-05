## An egg: a breed, a father and a mother (vault/Ovo.md).
class_name Egg
extends RefCounted

## Fictitious parents: each allele is the breed base ±10%.
const PARENT_VARIATION := 0.1
## Newborn initial stats: breed base ±10% (vault/Stats.md).
const INITIAL_STAT_VARIATION := 0.1
const BASE_PRICE := 650
const PRICE_PER_QUALITY := 1250.0
const MIN_PRICE := 400
const MAX_PRICE := 900

var breed: Breed
var father: Monster
var mother: Monster
var seed_value: int
var price: int


## Creates an egg from two random parents. The same breed and seed always give the same egg.
static func from_random_parents(egg_breed: Breed, egg_seed: int) -> Egg:
	var rng := RandomNumberGenerator.new()
	rng.seed = egg_seed
	var egg := Egg.new()
	egg.breed = egg_breed
	egg.seed_value = egg_seed
	egg.father = _random_parent(egg_breed, rng)
	egg.mother = _random_parent(egg_breed, rng)
	egg.price = price_for_quality(egg.expected_quality())
	return egg


## Mean of the two parents' growth rate sums.
func expected_quality() -> float:
	var total := 0.0
	for i in Monster.STAT_COUNT:
		total += father.growth_rates[i] + mother.growth_rates[i]
	return total / 2.0


static func price_for_quality(quality: float) -> int:
	var raw := roundi(BASE_PRICE + (quality - 6.0) * PRICE_PER_QUALITY)
	return clampi(roundi(raw / 10.0) * 10, MIN_PRICE, MAX_PRICE)


## Creates the newborn: one allele from each parent per stat, plus the word modifier.
func hatch(word_effect: WordEffect) -> Monster:
	var rng := RandomNumberGenerator.new()
	rng.seed = seed_value + 1  # A different stream from the one that made the parents.
	var child := Monster.new()
	child.breed = breed
	for i in Monster.STAT_COUNT:
		var a := father.alleles_a[i] if rng.randi() % 2 == 0 else father.alleles_b[i]
		var b := mother.alleles_a[i] if rng.randi() % 2 == 0 else mother.alleles_b[i]
		child.alleles_a.append(a)
		child.alleles_b.append(b)
		child.growth_rates.append((a + b) / 2.0 + word_effect.modifier(i))
	for i in Monster.STAT_COUNT:
		var variation := rng.randf_range(1.0 - INITIAL_STAT_VARIATION, 1.0 + INITIAL_STAT_VARIATION)
		child.stats.append(roundi(breed.initial_stats[i] * variation))
	return child


static func _random_parent(parent_breed: Breed, rng: RandomNumberGenerator) -> Monster:
	var parent := Monster.new()
	parent.breed = parent_breed
	for i in Monster.STAT_COUNT:
		var base: float = parent_breed.growth_rates[i]
		var a := base * rng.randf_range(1.0 - PARENT_VARIATION, 1.0 + PARENT_VARIATION)
		var b := base * rng.randf_range(1.0 - PARENT_VARIATION, 1.0 + PARENT_VARIATION)
		parent.alleles_a.append(a)
		parent.alleles_b.append(b)
		parent.growth_rates.append((a + b) / 2.0)
	return parent

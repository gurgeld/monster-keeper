## The effect of a word on growth rates (vault/Palavra.md).
class_name WordEffect
extends RefCounted

## 1 point = 0.05 on the growth rate.
const POINT := 0.05
const MAX_MINUS_POINTS := 3
const MAX_PLUS_POINTS := 4
## Chance (in %) of each sum: index = sum (plus − minus).
const SUM_CHANCES: Array[int] = [80, 15, 4, 1]

var plus_stat: int
var plus_points: int
var minus_stat: int
var minus_points: int


static func normalize(word: String) -> String:
	return word.strip_edges().to_lower()


## 3 to 7 letters (accents allowed), nothing else.
static func is_valid(word: String) -> bool:
	var regex := RegEx.create_from_string("^\\p{L}{3,7}$")
	return regex.search(normalize(word)) != null


## The same word and save seed always give the same effect.
static func from_word(word: String, save_seed: int) -> WordEffect:
	var rng := RandomNumberGenerator.new()
	rng.seed = hash("%d:%s" % [save_seed, normalize(word)])
	var effect := WordEffect.new()
	effect.plus_stat = rng.randi_range(0, Monster.STAT_COUNT - 1)
	effect.minus_stat = (effect.plus_stat + rng.randi_range(1, Monster.STAT_COUNT - 1)) % Monster.STAT_COUNT
	var total := _roll_sum(rng)
	effect.minus_points = rng.randi_range(1, mini(MAX_MINUS_POINTS, MAX_PLUS_POINTS - total))
	effect.plus_points = effect.minus_points + total
	return effect


## Change to the growth rate of one stat.
func modifier(stat: int) -> float:
	if stat == plus_stat:
		return plus_points * POINT
	if stat == minus_stat:
		return -minus_points * POINT
	return 0.0


static func _roll_sum(rng: RandomNumberGenerator) -> int:
	var roll := rng.randi_range(1, 100)
	for total in SUM_CHANCES.size():
		roll -= SUM_CHANCES[total]
		if roll <= 0:
			return total
	return 0

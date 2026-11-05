## One play session: shop, incubation and training weeks (vault/Protótipo jogável.md).
class_name Game
extends RefCounted

const TOTAL_WEEKS := 52
const INCUBATION_WEEKS := 4
const STARTING_MONEY := 1000
const SHOP_SIZE := 5

## Also the "save variable" used by words (vault/Palavra.md).
var seed_value: int
var money := STARTING_MONEY
var week := 1
var shop: Array[Egg] = []
var egg: Egg
var word := ""
var word_effect: WordEffect
var incubation_weeks_left := 0
var monster: Monster


func _init(game_seed: int, breeds: Array[Breed]) -> void:
	seed_value = game_seed
	var rng := RandomNumberGenerator.new()
	rng.seed = game_seed
	for i in SHOP_SIZE:
		var breed := breeds[rng.randi_range(0, breeds.size() - 1)]
		shop.append(Egg.from_random_parents(breed, rng.randi()))


func buy(index: int) -> void:
	egg = shop[index]
	money -= egg.price


func start_incubation(egg_word: String) -> void:
	word = WordEffect.normalize(egg_word)
	word_effect = WordEffect.from_word(word, seed_value)
	incubation_weeks_left = INCUBATION_WEEKS


## Passes one incubation week. The egg hatches when the incubation ends.
func wait_week() -> void:
	week += 1
	incubation_weeks_left -= 1
	if incubation_weeks_left == 0:
		monster = egg.hatch(word_effect)


## Trains one stat, ends the week and returns the gain.
func train(stat: Monster.Stat) -> int:
	var gain := monster.train(stat)
	week += 1
	return gain


func rest() -> void:
	monster.rest()
	week += 1


func is_over() -> bool:
	return week > TOTAL_WEEKS

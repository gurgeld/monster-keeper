# Run with: godot --headless --path project --script res://tests/test_runner.gd
extends SceneTree

const BREED_PATHS: Array[String] = [
	"res://data/breeds/tatuco.tres",
	"res://data/breeds/vulpi.tres",
	"res://data/breeds/runoxa.tres",
]
const SEEDS_TO_CHECK := 200

var passed := 0
var failed := 0


func _initialize() -> void:
	var tests: Array[String] = [
		"test_breeds_follow_balance_rules",
		"test_same_seed_gives_same_monster",
		"test_different_seeds_give_different_monsters",
		"test_growth_rates_vary_within_10_percent",
		"test_initial_stats_vary_within_10_percent",
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


# Rules from vault/Raças.md: growth rates sum to 6.0, initial stats sum to 300.
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


func test_same_seed_gives_same_monster() -> bool:
	for breed: Breed in load_breeds():
		var a := Monster.hatch(breed, 12345)
		var b := Monster.hatch(breed, 12345)
		check(a.breed == breed, "%s monster keeps its breed" % breed.name)
		check(a.growth_rates == b.growth_rates, "%s same seed, same growth rates" % breed.name)
		check(a.stats == b.stats, "%s same seed, same stats" % breed.name)
	return true


func test_different_seeds_give_different_monsters() -> bool:
	var breed: Breed = load_breeds()[0]
	var a := Monster.hatch(breed, 1)
	var b := Monster.hatch(breed, 2)
	check(a.growth_rates != b.growth_rates, "different seeds, different growth rates")
	return true


func test_growth_rates_vary_within_10_percent() -> bool:
	for breed: Breed in load_breeds():
		var all_ok := true
		for seed_value in SEEDS_TO_CHECK:
			var monster := Monster.hatch(breed, seed_value)
			for i in Monster.STAT_COUNT:
				var base: float = breed.growth_rates[i]
				var rate: float = monster.growth_rates[i]
				if rate < base * 0.9 - 0.0001 or rate > base * 1.1 + 0.0001:
					all_ok = false
		check(all_ok, "%s growth rates stay within base ±10%%" % breed.name)
	return true


func test_initial_stats_vary_within_10_percent() -> bool:
	for breed: Breed in load_breeds():
		var all_ok := true
		for seed_value in SEEDS_TO_CHECK:
			var monster := Monster.hatch(breed, seed_value)
			for i in Monster.STAT_COUNT:
				var base: int = breed.initial_stats[i]
				var stat: int = monster.stats[i]
				if stat < roundi(base * 0.9) or stat > roundi(base * 1.1):
					all_ok = false
		check(all_ok, "%s initial stats stay within base ±10%%" % breed.name)
	return true

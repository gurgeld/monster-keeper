# Run with: godot --headless --path project --script res://tests/test_runner.gd
extends SceneTree

const BREED_PATHS: Array[String] = [
	"res://data/breeds/tatuco.tres",
	"res://data/breeds/vulpi.tres",
	"res://data/breeds/runoxa.tres",
]
const RULES_PATH := "res://data/rules.tres"
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
		"test_training_gain_uses_growth_rate",
		"test_fatigue_reduces_gain",
		"test_fatigue_stays_between_0_and_100",
		"test_stats_cap_at_999",
		"test_grade_letters",
		"test_new_game_starts_at_week_1",
		"test_advance_week_has_no_end",
		"test_first_pending_is_buy_an_egg",
		"test_entity_ids_are_unique",
		"test_event_seed",
		"test_same_seed_and_commands_give_same_state",
		"test_save_round_trip",
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


func test_grade_letters() -> bool:
	check(Monster.grade(0.5) == "E", "0.5 is E")
	check(Monster.grade(0.7) == "D", "0.7 is D")
	check(Monster.grade(1.0) == "C", "1.0 is C")
	check(Monster.grade(1.1) == "B", "1.1 is B")
	check(Monster.grade(1.3) == "A", "1.3 is A")
	check(Monster.grade(1.54) == "A", "above 1.5 shows A for now")
	return true


# --- Game, version 3 (vault/Protótipo jogável.md, vault/Treino semanal.md) ---

func new_game(game_seed: int) -> Game:
	return Game.new(load(RULES_PATH) as GameRules, game_seed)


func test_new_game_starts_at_week_1() -> bool:
	var game := new_game(1)
	check(game.week == 1, "new game starts at week 1")
	check(game.money == 1000, "new game starts with 1000 money")
	check(game.slots == 3, "new game starts with 3 slots")
	return true


func test_advance_week_has_no_end() -> bool:
	var game := new_game(1)
	var report := game.advance_week()
	check(game.week == 2, "advancing a week adds 1 to the week")
	check(report["week"] == 1, "the report tells which week was played")
	for i in 60:
		game.advance_week()
	check(game.week == 62, "the game goes on after week 52")
	return true


func test_first_pending_is_buy_an_egg() -> bool:
	var pending := new_game(1).pending()
	check(pending.size() == 1, "a new game has 1 pending item")
	check(pending[0]["text"] == "Compre um ovo na loja", "the pending item is to buy an egg")
	check(pending[0]["screen"] == "shop", "the pending item opens the shop")
	return true


func test_entity_ids_are_unique() -> bool:
	var game := new_game(1)
	var ids := {}
	for i in 20:
		ids[game.new_entity_id()] = true
	check(ids.size() == 20, "20 new entities get 20 different IDs")
	return true


func test_event_seed() -> bool:
	var base := Game.event_seed(42, 5, 7, "hatch")
	check(base == Game.event_seed(42, 5, 7, "hatch"), "same inputs give the same seed")
	check(base != Game.event_seed(43, 5, 7, "hatch"), "another game seed gives another seed")
	check(base != Game.event_seed(42, 6, 7, "hatch"), "another week gives another seed")
	check(base != Game.event_seed(42, 5, 8, "hatch"), "another entity ID gives another seed")
	check(base != Game.event_seed(42, 5, 7, "shop"), "another roll kind gives another seed")
	# Swapped numbers must not collide (e.g. week 5 / ID 7 and week 7 / ID 5).
	check(base != Game.event_seed(42, 7, 5, "hatch"), "swapping week and ID gives another seed")
	return true


## Runs the same commands on a game: some weeks, with new entities on the way.
func play_weeks(game: Game, weeks: int) -> void:
	for i in weeks:
		if i % 3 == 0:
			game.new_entity_id()
		game.advance_week()


func test_same_seed_and_commands_give_same_state() -> bool:
	var a := new_game(2024)
	var b := new_game(2024)
	play_weeks(a, 10)
	play_weeks(b, 10)
	check(a.to_dict() == b.to_dict(), "same seed and commands give the same state after 10 weeks")
	return true


func test_save_round_trip() -> bool:
	# Above 2^53: a JSON number would lose the last digits, the text must not.
	var big_seed := 9007199254740993
	var original := new_game(big_seed)
	play_weeks(original, 5)
	var json := JSON.stringify(original.to_dict())
	var loaded := Game.from_dict(JSON.parse_string(json), load(RULES_PATH) as GameRules)
	check(loaded.game_seed == big_seed, "the game seed survives the JSON as text")
	check(loaded.to_dict() == original.to_dict(), "to_dict -> JSON -> from_dict gives the same state")
	play_weeks(original, 5)
	play_weeks(loaded, 5)
	check(loaded.to_dict() == original.to_dict(), "the weeks after loading give the same result")
	check(loaded.new_entity_id() == original.new_entity_id(), "the ID counter survives the save")
	return true

## One play session, version 3 (vault/Protótipo jogável.md). The game has no end.
## The UI only calls commands and reads the state.
class_name Game
extends RefCounted

var rules: GameRules
## Every roll gets its own seed from this one (vault/Aleatoriedade determinística.md).
var game_seed: int
var week := 1
var money: int
var slots: int
## The next fixed ID for a monster or an egg.
var next_entity_id := 1


func _init(game_rules: GameRules, new_game_seed: int) -> void:
	rules = game_rules
	game_seed = new_game_seed
	money = rules.starting_money
	slots = rules.starting_slots


## The seed of one roll. Each roll makes its own RandomNumberGenerator with it,
## so one roll never changes another, and no generator goes in the save.
## kind is a fixed text, for example "hatch" or "shop".
static func event_seed(seed_of_game: int, roll_week: int, entity_id: int, kind: String) -> int:
	# MD5 does not change between engine versions, so old saves keep their results.
	# 15 hex digits = 60 bits, always a positive int.
	var text := "%d:%d:%d:%s" % [seed_of_game, roll_week, entity_id, kind]
	return text.md5_text().substr(0, 15).hex_to_int()


func new_entity_id() -> int:
	next_entity_id += 1
	return next_entity_id - 1


## Plays the whole week in the fixed order of vault/Treino semanal.md and returns the report.
func advance_week() -> Dictionary:
	var report := {"week": week}
	# 1. Decide each monster's action. 2. Run the actions. 3. Age. 4. Breeding.
	# 5. Incubation. (These steps come with monsters and eggs.)
	# 6. World:
	week += 1
	# 7. Report (the save comes with the save store).
	return report


## Decisions the player can make now. None of them blocks the week (vault/Fluxo de telas.md).
## screen is the ID of the screen the button opens.
func pending() -> Array[Dictionary]:
	# "No monster and no egg" is always true until the shop and eggs exist.
	return [{"text": "Compre um ovo na loja", "screen": "shop"}]


## A copy of the state with no design data. The seed is text, because JSON numbers
## are floats and lose digits of a 64-bit seed.
func to_dict() -> Dictionary:
	return {
		"game_seed": str(game_seed),
		"week": week,
		"money": money,
		"slots": slots,
		"next_entity_id": next_entity_id,
	}


static func from_dict(data: Dictionary, game_rules: GameRules) -> Game:
	var game := Game.new(game_rules, String(data["game_seed"]).to_int())
	game.week = int(data["week"])
	game.money = int(data["money"])
	game.slots = int(data["slots"])
	game.next_entity_id = int(data["next_entity_id"])
	return game

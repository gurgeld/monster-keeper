## Prototype screen: choose an egg, train for 52 weeks, see the result.
## The UI is built in code because it is temporary (vault/Protótipo jogável.md).
extends Control

const BREED_PATHS: Array[String] = [
	"res://data/breeds/tatuco.tres",
	"res://data/breeds/vulpi.tres",
	"res://data/breeds/runoxa.tres",
]
const STAT_NAMES: Array[String] = [
	"Vida", "Força", "Inteligência", "Precisão", "Velocidade", "Defesa",
]

var game: Game
var game_seed := 0
var last_message := ""

@onready var content: VBoxContainer = $Margin/Content


func _ready() -> void:
	show_egg_choice()


func clear_content() -> void:
	for child in content.get_children():
		child.queue_free()


func add_label(text: String, font_size := 16) -> Label:
	var label := Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", font_size)
	content.add_child(label)
	return label


func add_button(text: String, on_pressed: Callable, parent: Node = content) -> Button:
	var button := Button.new()
	button.text = text
	button.pressed.connect(on_pressed)
	parent.add_child(button)
	return button


func show_egg_choice() -> void:
	clear_content()
	add_label("Escolha um ovo", 28)
	var first_button: Button = null
	for path: String in BREED_PATHS:
		var breed: Breed = load(path)
		var grades: Array[String] = []
		for i in Monster.STAT_COUNT:
			grades.append("%s %s" % [STAT_NAMES[i].left(3), Monster.grade(breed.growth_rates[i])])
		var button := add_button(
			"%s   (%s)" % [breed.name, " · ".join(grades)], start_game.bind(breed))
		if first_button == null:
			first_button = button
	first_button.grab_focus()


func start_game(breed: Breed) -> void:
	game_seed = randi()
	game = Game.new(Monster.hatch(breed, game_seed))
	last_message = "O ovo chocou! Nasceu um %s." % breed.name
	show_ranch()


func show_ranch() -> void:
	if game.is_over():
		show_end()
		return
	clear_content()
	var monster := game.monster
	add_label("Semana %d / %d" % [game.week, Game.TOTAL_WEEKS], 28)
	add_label("%s   (seed %d)" % [monster.breed.name, game_seed])

	var grid := GridContainer.new()
	grid.columns = 4
	grid.add_theme_constant_override("h_separation", 24)
	content.add_child(grid)
	for header: String in ["Stat", "Valor", "Taxa", ""]:
		var label := Label.new()
		label.text = header
		grid.add_child(label)
	var first_button: Button = null
	for i in Monster.STAT_COUNT:
		var name_label := Label.new()
		name_label.text = STAT_NAMES[i]
		grid.add_child(name_label)
		var value_label := Label.new()
		value_label.text = str(monster.stats[i])
		grid.add_child(value_label)
		var grade_label := Label.new()
		grade_label.text = Monster.grade(monster.growth_rates[i])
		grid.add_child(grade_label)
		var button := add_button("Treinar", on_train.bind(i), grid)
		if first_button == null:
			first_button = button

	var fatigue_row := HBoxContainer.new()
	content.add_child(fatigue_row)
	var fatigue_label := Label.new()
	fatigue_label.text = "Fadiga"
	fatigue_row.add_child(fatigue_label)
	var fatigue_bar := ProgressBar.new()
	fatigue_bar.max_value = Monster.MAX_FATIGUE
	fatigue_bar.value = monster.fatigue
	fatigue_bar.custom_minimum_size = Vector2(240, 0)
	fatigue_row.add_child(fatigue_bar)

	add_button("Descansar", on_rest)
	add_label(last_message)
	first_button.grab_focus()


func on_train(stat: int) -> void:
	var gain := game.train(stat as Monster.Stat)
	last_message = "Treinou %s: +%d." % [STAT_NAMES[stat], gain]
	show_ranch()


func on_rest() -> void:
	game.rest()
	last_message = "Descansou. Fadiga agora: %d." % game.monster.fatigue
	show_ranch()


func show_end() -> void:
	clear_content()
	var monster := game.monster
	add_label("Fim! %d semanas se passaram." % Game.TOTAL_WEEKS, 28)
	add_label("%s   (seed %d)" % [monster.breed.name, game_seed])
	var total := 0
	for i in Monster.STAT_COUNT:
		add_label("%s: %d" % [STAT_NAMES[i], monster.stats[i]])
		total += monster.stats[i]
	add_label("Total: %d" % total, 22)
	add_button("Novo jogo", show_egg_choice).grab_focus()

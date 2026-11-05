## Prototype screen: buy an egg, incubate it with a word, train, see the result.
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
var last_message := ""

@onready var content: VBoxContainer = $Margin/Content


func _ready() -> void:
	start_new_game()


func clear_content() -> void:
	for child in content.get_children():
		child.queue_free()


func add_label(text: String, font_size := 16, parent: Node = content) -> Label:
	var label := Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", font_size)
	parent.add_child(label)
	return label


func add_button(text: String, on_pressed: Callable, parent: Node = content) -> Button:
	var button := Button.new()
	button.text = text
	button.pressed.connect(on_pressed)
	parent.add_child(button)
	return button


func add_header() -> void:
	add_label("Semana %d / %d" % [game.week, Game.TOTAL_WEEKS], 28)
	add_label("Dinheiro: %d   (seed %d)" % [game.money, game.seed_value])


## Letters of the six growth rates, e.g. "Vid A · For C · ...".
func grades_text(rates: Array[float]) -> String:
	var grades: Array[String] = []
	for i in Monster.STAT_COUNT:
		grades.append("%s %s" % [STAT_NAMES[i].left(3), Monster.grade(rates[i])])
	return " · ".join(grades)


func word_effect_text(effect: WordEffect) -> String:
	return "+%d %s, −%d %s" % [
		effect.plus_points, STAT_NAMES[effect.plus_stat],
		effect.minus_points, STAT_NAMES[effect.minus_stat],
	]


func start_new_game() -> void:
	var breeds: Array[Breed] = []
	for path: String in BREED_PATHS:
		breeds.append(load(path) as Breed)
	game = Game.new(randi(), breeds)
	show_shop()


# --- Shop (vault/Ovo.md) ---

func show_shop() -> void:
	clear_content()
	add_header()
	add_label("Loja de ovos", 22)
	add_label("Você vê as taxas dos pais. O filho herda um alelo de cada pai, então o resultado varia.")
	var first_button: Button = null
	for i in game.shop.size():
		var egg := game.shop[i]
		var box := VBoxContainer.new()
		content.add_child(box)
		var row := HBoxContainer.new()
		box.add_child(row)
		var button := add_button("Comprar", on_buy.bind(i), row)
		add_label("Ovo de %s — %d" % [egg.breed.name, egg.price], 18, row)
		add_label("    Pai: " + grades_text(egg.father.growth_rates), 14, box)
		add_label("    Mãe: " + grades_text(egg.mother.growth_rates), 14, box)
		if first_button == null:
			first_button = button
	first_button.grab_focus()


func on_buy(index: int) -> void:
	game.buy(index)
	show_word_entry()


# --- Word (vault/Palavra.md) ---

func show_word_entry() -> void:
	clear_content()
	add_header()
	add_label("Incubação: ovo de %s" % game.egg.breed.name, 22)
	add_label("Lance uma palavra sobre o ovo (3 a 7 letras).")
	add_label("Ela muda a facilidade de ganhar stats. Você só vê o efeito quando o ovo chocar.")
	var row := HBoxContainer.new()
	content.add_child(row)
	var input := LineEdit.new()
	input.max_length = 7
	input.custom_minimum_size = Vector2(200, 0)
	row.add_child(input)
	var button := add_button("Lançar palavra", func() -> void: on_word_submitted(input.text), row)
	button.disabled = true
	input.text_changed.connect(func(text: String) -> void: button.disabled = not WordEffect.is_valid(text))
	input.text_submitted.connect(on_word_submitted)
	input.grab_focus()


func on_word_submitted(text: String) -> void:
	if not WordEffect.is_valid(text):
		return
	game.start_incubation(text)
	show_incubation()


# --- Incubation ---

func show_incubation() -> void:
	clear_content()
	add_header()
	add_label("Incubando ovo de %s" % game.egg.breed.name, 22)
	add_label("Palavra: \"%s\"" % game.word)
	add_label("Faltam %d semana(s) para chocar." % game.incubation_weeks_left)
	add_button("Esperar uma semana", on_wait).grab_focus()


func on_wait() -> void:
	game.wait_week()
	if game.monster == null:
		show_incubation()
		return
	last_message = "O ovo chocou! Nasceu um %s. A palavra \"%s\" deu: %s." % [
		game.monster.breed.name, game.word, word_effect_text(game.word_effect)]
	show_ranch()


# --- Training (vault/Treino semanal.md) ---

func show_ranch() -> void:
	if game.is_over():
		show_end()
		return
	clear_content()
	var monster := game.monster
	add_header()
	add_label("%s   (palavra \"%s\")" % [monster.breed.name, game.word])

	var grid := GridContainer.new()
	grid.columns = 4
	grid.add_theme_constant_override("h_separation", 24)
	content.add_child(grid)
	for header: String in ["Stat", "Valor", "Taxa", ""]:
		add_label(header, 16, grid)
	var first_button: Button = null
	for i in Monster.STAT_COUNT:
		add_label(STAT_NAMES[i], 16, grid)
		add_label(str(monster.stats[i]), 16, grid)
		add_label(Monster.grade(monster.growth_rates[i]), 16, grid)
		var button := add_button("Treinar", on_train.bind(i), grid)
		if first_button == null:
			first_button = button

	var fatigue_row := HBoxContainer.new()
	content.add_child(fatigue_row)
	add_label("Fadiga", 16, fatigue_row)
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
	add_label("%s   (palavra \"%s\": %s)" % [
		monster.breed.name, game.word, word_effect_text(game.word_effect)])
	var total := 0
	for i in Monster.STAT_COUNT:
		add_label("%s: %d" % [STAT_NAMES[i], monster.stats[i]])
		total += monster.stats[i]
	add_label("Total: %d" % total, 22)
	add_button("Novo jogo", start_new_game).grab_focus()

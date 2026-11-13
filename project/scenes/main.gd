## Prototype screens, version 3: the Week screen and the "Mais" menu (vault/Fluxo de telas.md).
## The UI is built in code because it is temporary. It has no game rules.
extends Control

const RULES_PATH := "res://data/rules.tres"
## Screen ID → title. The screens are empty for now.
const SCREENS := {
	"shop": "Loja",
	"eggs": "Ovos",
	"calendar": "Calendário",
	"breeding": "Procriação",
	"words": "Caderno de palavras",
	"slots": "Vagas e venda",
	"memorial": "Memorial",
	"game": "Jogo",
}

var game: Game
var last_report := {}

@onready var content: VBoxContainer = $Margin/Content


func _ready() -> void:
	# The game seed is rolled with no choice by the player.
	game = Game.new(load(RULES_PATH) as GameRules, randi())
	show_week()


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


# --- Week ---

func show_week() -> void:
	clear_content()
	add_label("Semana %d" % game.week, 28)
	add_label("Dinheiro: %d   Vagas: %d" % [game.money, game.slots])

	if not last_report.is_empty():
		add_label("O que aconteceu", 22)
		add_label("A semana %d passou." % last_report["week"])

	add_label("Pendências", 22)
	for item: Dictionary in game.pending():
		var row := HBoxContainer.new()
		content.add_child(row)
		add_label(item["text"], 16, row)
		add_button(SCREENS[item["screen"]], show_screen.bind(item["screen"]), row)

	add_button("Passar 1 semana", on_advance_week).grab_focus()

	add_label("Mais", 22)
	var more := HFlowContainer.new()
	content.add_child(more)
	for screen: String in SCREENS:
		add_button(SCREENS[screen], show_screen.bind(screen), more)


func on_advance_week() -> void:
	last_report = game.advance_week()
	show_week()


# --- Other screens (empty for now) ---

func show_screen(screen: String) -> void:
	clear_content()
	add_label(SCREENS[screen], 28)
	add_label("Esta tela ainda está vazia.")
	add_button("Voltar", show_week).grab_focus()

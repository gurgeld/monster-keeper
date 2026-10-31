extends SceneTree
## Teste de fumaça: carrega a cena principal e sai com código 0 se ok.
## Uso: godot --headless --path project --script res://tests/smoke_test.gd


func _init() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn")
	if scene == null:
		push_error("Falha ao carregar res://scenes/main.tscn")
		quit(1)
		return
	var inst := scene.instantiate()
	root.add_child(inst)
	print("OK: cena principal instanciada")
	quit(0)

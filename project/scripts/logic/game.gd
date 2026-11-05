## One play session: a monster and the passing weeks (vault/Protótipo jogável.md).
class_name Game
extends RefCounted

const TOTAL_WEEKS := 52

var monster: Monster
var week := 1


func _init(game_monster: Monster) -> void:
	monster = game_monster


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

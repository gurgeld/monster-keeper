## Design data for a breed. Values come from vault/Raças.md.
## Arrays follow the order of Monster.Stat.
class_name Breed
extends Resource

@export var name: String = ""
@export var growth_rates: Array[float] = []
@export var initial_stats: Array[int] = []

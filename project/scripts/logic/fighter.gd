## What the battle needs to know about one monster. Built by the caller
## (tournament, opponent generator) so the battle has no access to Game.
class_name Fighter
extends RefCounted

var breed: Breed
## Follows the order of Monster.Stat.
var stats: Array[int] = []
## Indexes into breed.skills. Skills stay unlocked even if the stat drops.
var unlocked_skills: Array[int] = []
## 0 to 100 (vault/Atributos de estado.md). Opponents use 100.
var obedience: int = 100
var strategy: Battle.Strategy = Battle.Strategy.BALANCED


static func create(p_breed: Breed, p_stats: Array[int], p_unlocked: Array[int],
		p_obedience: int, p_strategy: Battle.Strategy) -> Fighter:
	var fighter := Fighter.new()
	fighter.breed = p_breed
	fighter.stats = p_stats
	fighter.unlocked_skills = p_unlocked
	fighter.obedience = p_obedience
	fighter.strategy = p_strategy
	return fighter

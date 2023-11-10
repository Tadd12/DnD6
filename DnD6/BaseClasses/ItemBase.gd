class_name ItemBase
extends Object

# Proprties
var name
var weight
var inventoryIcon


func open_world_usage(user: CharacterBase) -> bool:
	return false

func encounter_usage(user: CharacterBase) -> bool:
	return false
	

# static

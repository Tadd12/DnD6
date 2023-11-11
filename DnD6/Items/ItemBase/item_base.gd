class_name ItemBase
extends Node2D

@export_group("Properties")
## Name of the Item
@export var itemName: String
## The Weight of the Item
@export var weight: float
## The icon to be shown in the inventory 
@export var inventoryIcon: Texture2D

@export_group("Effects")
@export var effects: Dictionary = {}

func getMetadata() -> Dictionary:
	return {'Name': itemName,
			'Weight': weight}

func _world_usage(user):
	pass

func _encounter_usage(user):
	pass
	

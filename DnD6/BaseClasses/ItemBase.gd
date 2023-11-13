class_name ItemBase
extends Resource

# Proprties
## Name of the Item
var itemName: String
## The Weight of the Item
var weight: float
## The icon to be shown in the inventory 
var inventoryIcon: ImageTexture = ImageTexture.create_from_image(Image.load_from_file("res://Sprites//MissingIcon.png"))
##
var listOfEffects: Array

func _init(pName, pWeight, effects=null, icon=null):
	self.itemName = pName
	self.weight = pWeight
	if effects != null:
		self.listOfEffects = effects
	if icon != null:
		if icon is ImageTexture:
			self.inventoryIcon = icon
		if icon is String:
			self.inventoryIcon = ImageTexture.create_from_image(
				Image.load_from_file(icon))


func getMetadata():
	return {'Name': itemName,
			'Weight': weight}

func open_world_usage(user: CharacterBase) -> bool:
	return false

func encounter_usage(user: CharacterBase) -> bool:
	return false
	

# static

class_name ItemBase
extends Node2D

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
		self.inventoryIcon = icon

# static

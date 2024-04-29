class_name ConsumableBase
extends ItemBase

enum CONSUMABLE_TYPE {
	FOOD,
	POTION
}

@export var ConsumableType: CONSUMABLE_TYPE
@export var usableInFigth: bool
@export var usableOnPlayer: bool
@export var usableOnItem: bool

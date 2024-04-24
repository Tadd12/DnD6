extends StaticBody2D

signal toggleInventory(externalInventoryOwner, keepOpen)

@export var inventoryData: InventoryData

func playerInteract() -> void:
	toggleInventory.emit(self, true)

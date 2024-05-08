extends Node

@onready var player := $Game/Player
@onready var inventoryInterface := $UI/InventoryInterface as InventoryInterface


func _ready() -> void:
	player.toggleInventory.connect(toggleInventoryInterface)
	inventoryInterface.setPlayerInventory(player.inventoryData)
	player.closeUi.connect(_closeUi)	
	for node in get_tree().get_nodes_in_group("externalInventory"):
		node.toggleInventory.connect(toggleInventoryInterface)

func _closeUi():
	if inventoryInterface.visible:
		toggleInventoryInterface()


## Toggles the visibility of the inventory interface.
## If an [param externalInventoryOwner] is provided, an additional inventory will open to display the contens.
## If [param keepOpen] is provided and the inventory is visible, it will stay visible.
func toggleInventoryInterface(externalInventoryOwner = null, keepOpen = false) -> void:
	if inventoryInterface.visible and keepOpen:
		pass
	else:
		inventoryInterface.visible = not inventoryInterface.visible
	
	
	if inventoryInterface.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		inventoryInterface.dropGrabbedSlot()
	
	if externalInventoryOwner and inventoryInterface.visible:
		inventoryInterface.setExternalInventory(externalInventoryOwner)
	else:
		inventoryInterface.clearExternalInventory()

extends Node

@onready var player := $Game/Player
@onready var inventory_interface := $UI/InventoryInterface


func _ready() -> void:
	player.toggleInventory.connect(toggleInventory_interface)
	inventory_interface.set_playerInventory(player.inventoryData)
	player.close_ui.connect(_close_ui)	
	for node in get_tree().get_nodes_in_group("external_inventory"):
		node.toggleInventory.connect(toggleInventory_interface)

func _close_ui():
	if inventory_interface.visible:
		toggleInventory_interface()


#desc Toggles the visibility of the inventory interface.
#desc If an [param externalInventoryOwner] is provided, an additional inventory will open to display the contens.
#desc If [param keepOpen] is provided and the inventory is visible, it will stay visible.
func toggleInventory_interface(externalInventoryOwner = null, keepOpen = false) -> void:
	if inventory_interface.visible and keepOpen:
		pass
	else:
		inventory_interface.visible = not inventory_interface.visible
	
	
	if inventory_interface.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		inventory_interface.drop_grabbedSlot()
	
	if externalInventoryOwner and inventory_interface.visible:
		inventory_interface.set_externalInventory(externalInventoryOwner)
	else:
		inventory_interface.clear_externalInventory()

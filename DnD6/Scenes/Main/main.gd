extends Node

@onready var player = $Game/Player
@onready var inventory_interface = $UI/InventoryInterface


func _ready() -> void:
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.set_player_inventory(player.inventory_data)
	player.close_ui.connect(_close_ui)	
	for node in get_tree().get_nodes_in_group("external_inventory"):
		node.toggle_inventory.connect(toggle_inventory_interface)

func _close_ui():
	if inventory_interface.visible:
		toggle_inventory_interface()

func toggle_inventory_interface(external_inventory_owner = null, keep_open = false) -> void:
	if inventory_interface.visible and keep_open:
		pass
	else:
		inventory_interface.visible = not inventory_interface.visible
	
	
	if inventory_interface.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	if external_inventory_owner and inventory_interface.visible:
		inventory_interface.set_external_inventory(external_inventory_owner)
	else:
		inventory_interface.clear_external_inventory()

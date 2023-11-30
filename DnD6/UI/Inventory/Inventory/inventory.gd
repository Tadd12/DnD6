extends PanelContainer

const Slot = preload("res://UI/Inventory/Slot/slot.tscn")

@onready var item_grid = $MarginContainer/ScrollContainer/ItemGrid


func _ready():
	var inventory_data = preload("res://UI/Inventory/test_inv.tres")
	populate_item_grid(inventory_data)
	
func set_inventory_data(inventory_data: InventoryData) -> void:
	inventory_data.inventory_updated.connect(populate_item_grid)
	populate_item_grid(inventory_data)
	
	var calc_size: int =  min((inventory_data.slot_datas.size() + 4) / 5, 412)
	size.y = 4 + 68 * calc_size

func clear_inventory_data(inventory_data: InventoryData) -> void:
	inventory_data.inventory_updated.disconnect(populate_item_grid)

func populate_item_grid(inventory_data: InventoryData) -> void:
	for child in item_grid.get_children():
		child.queue_free()
		
	for slot_data in inventory_data.slot_datas:
		var slot = Slot.instantiate()
		item_grid.add_child(slot)
		
		slot.slot_clicked.connect(inventory_data.on_slot_clicked)
		
		if slot_data:
			slot.set_slot_data(slot_data)
	

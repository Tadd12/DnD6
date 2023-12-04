extends PanelContainer

const Slot := preload("res://UI/Inventory/Slot/slot.tscn")

@onready var item_grid := $MarginContainer/ScrollContainer/ItemGrid


func _ready():
	var inventoryData := preload("res://UI/Inventory/test_inv.tres")
	populate_item_grid(inventoryData)
	
	
#desc Sets the data displayed in the inventory
func setInventoryData(inventoryData: InventoryData) -> void:
	inventoryData.inventoryUpdated.connect(populate_item_grid)
	populate_item_grid(inventoryData)
	
	var calc_size: int =  min((inventoryData.slotDatas.size() + 4) / 5, 412)
	size.y = 4 + 68 * calc_size

	
#desc Clears the display of the inventory
func clearInventoryData(inventoryData: InventoryData) -> void:
	inventoryData.inventoryUpdated.disconnect(populate_item_grid)

	
#desc Sets the data of the slots in the inventory
func populate_item_grid(inventoryData: InventoryData) -> void:
	for child in item_grid.get_children():
		child.queue_free()
		
	for slotData in inventoryData.slotDatas:
		var slot = Slot.instantiate()
		item_grid.add_child(slot)
		
		slot.slotClicked.connect(inventoryData.on_slotClicked)
		
		if slotData:
			slot.setSlotData(slotData)
	

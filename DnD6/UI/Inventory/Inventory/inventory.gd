extends PanelContainer

const Slot := preload("res://UI/Inventory/Slot/slot.tscn")

@onready var itemGrid := $MarginContainer/ScrollContainer/ItemGrid


func _ready():
	var inventoryData := preload("res://UI/Inventory/test_inv.tres")
	refreshItemGrid(inventoryData)
	
	
#desc Sets the data displayed in the inventory
func setInventoryData(inventoryData: InventoryData) -> void:
	inventoryData.inventoryUpdated.connect(refreshItemGrid)
	refreshItemGrid(inventoryData)
	
	var calc_size: int =  min((inventoryData.slotDatas.size() + 4) / 5, 412)
	size.y = 4 + 68 * calc_size

	
#desc Clears the display of the inventory
func clearInventoryData(inventoryData: InventoryData) -> void:
	inventoryData.inventoryUpdated.disconnect(refreshItemGrid)

	
#desc Sets the data of the slots in the inventory
func refreshItemGrid(inventoryData: InventoryData) -> void:
	for child in itemGrid.get_children():
		child.queue_free()
		
	for slotData in inventoryData.slotDatas:
		var slot = Slot.instantiate()
		itemGrid.add_child(slot)
		
		slot.slotClicked.connect(inventoryData._onSlotClicked)
		
		if slotData:
			slot.setSlotData(slotData)
	

extends PanelContainer
class_name Inventory

const SlotScene := preload("res://UI/Inventory/Slot/slot.tscn")

@onready var itemGrid := $MarginContainer/ScrollContainer/ItemGrid


func _ready():
	var inventoryData := preload("res://UI/Inventory/test_inv.tres") as InventoryData
	refreshItemGrid(inventoryData)
	
	
## Sets the data displayed in the inventory
func setInventoryData(inventoryData: InventoryData) -> void:
	inventoryData.inventoryUpdated.connect(refreshItemGrid)
	refreshItemGrid(inventoryData)
	
	var calcSize: int =  min((inventoryData.slotDatas.size() + 4) / 5, 412)
	var newSize := get_size()
	newSize.y = 4 + 68 * calcSize
	set_size(newSize)

	
## Clears the display of the inventory
func clearInventoryData(inventoryData: InventoryData) -> void:
	inventoryData.inventoryUpdated.disconnect(refreshItemGrid)

	
## Sets the data of the slots in the inventory
func refreshItemGrid(inventoryData: InventoryData) -> void:
	for child in itemGrid.get_children():
		child.queue_free()

	for slotData in inventoryData.slotDatas:
		var slot := SlotScene.instantiate() as Slot
		itemGrid.add_child(slot)
		
		slot.slotClicked.connect(inventoryData._onSlotClicked)
		if slotData:
			slot.setSlotData(slotData)

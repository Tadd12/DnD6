extends Control
class_name ShowInventory


@export var inventory: InventoryBase = null
@onready var itemListObj: ItemList = $ItemList

var items = []

# Set item-list in my inventory
func _build_inventory():
	items = inventory.contens.values()
	for item in items:
		var idx := itemListObj.add_item(item.itemName, item.inventoryIcon)
		itemListObj.set_item_metadata(idx, item.getMetadata())

func toggle_inventory():
	set_visible(not visible)
	
func _ready():
	_build_inventory()
	set_visible(false)

func getOpen():
	return visible
	
	

extends Control

@export var inventory: BaseInventory = null
@onready var item_list: ItemList = $ItemList

var items = inventory.contens

# Set item-list in my inventory
func _build_inventory():
	for item in items:
		var idx := item_list.add_item(item.itemName, item.inventoryIcon)
		set_item_metadata(idx, item.getMetadata())

func toggle_inventory():
	set_visible(not visible)
	
func _ready():
	_build_inventory()
	set_visible(false)
	
	

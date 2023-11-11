extends ItemList


# Called when the node enters the scene tree for the first time.
func _ready():
	self.max_columns = 2
	self.icon_mode = ICON_MODE_TOP
	self.max_text_lines = 1
	self.allow_reselect = true
	self.fixed_icon_size = Vector2i(100, 100)

func add_item(Item:ItemBase):
	var idx := super.add_item(Item.itemName, Item.inventoryIcon)
	set_item_metadata(idx, Item.getMetadata())
	
#func remove_item(Item:ItemBase):
#	var idx := remove_item(Item.itemName, Item.inventoryIcon)

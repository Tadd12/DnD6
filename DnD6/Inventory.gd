extends ItemList


# Called when the node enters the scene tree for the first time.
func _ready():
	self.max_columns = 4
	self.icon_mode = ICON_MODE_TOP
	self.max_text_lines = 1
	self.allow_reselect = true
	self.fixed_icon_size = Vector2i(100, 100)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func addItem(Item:ItemBase):
	var idx = add_item(Item.itemName, Item.inventoryIcon)
	set_item_metadata(idx, Item.getMetadata())


func _setItems(items: Array ):
	self.clear()
	for item in items:
		addItem(item)

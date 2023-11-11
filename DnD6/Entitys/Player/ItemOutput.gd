extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_inventory_item_selected(index):
	var metadata = $"../Inventory".get_item_metadata(index)
	self.clear()
	for k in metadata:
		var text := "[b]{0}[/b]: {1}\n".format([k, metadata[k]])
		self.append_text(text)

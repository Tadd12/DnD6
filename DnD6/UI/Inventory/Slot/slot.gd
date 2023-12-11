extends PanelContainer

signal slotClicked(index: int, button: int, doubleClicked: bool)


@onready var textureRect := $MarginContainer/TextureRect
@onready var quantityLabel := $QuantityLabel

#desc Sets the data for this slot
func setSlotData(slotData: SlotData) -> void:
	var itemData = slotData.itemData
	textureRect.texture = itemData.texture
	tooltip_text = "{0}\n{1}".format([itemData.name, itemData.description])
	
	if slotData.quantity > 1:
		quantityLabel.text = "x{0}".format([slotData.quantity])
		quantityLabel.show()
	else:
		quantityLabel.hide()


func _on_gui_input(event):
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
		slotClicked.emit(get_index(), event.button_index, event.is_doubleClicked_click())
		

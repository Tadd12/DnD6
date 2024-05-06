extends PanelContainer
class_name ItemOptions

var infoButton : Button
var useButton : Button
var removeButton : Button
var removeAllButton : Button
var inventoryData: InventoryData
var index: int

@onready var vBoxContainer := $VBoxContainer

func _ready():
	infoButton = Button.new()
	infoButton.text = "Info"
	infoButton.add_theme_font_size_override("button_font_size", 10)
	vBoxContainer.add_child(infoButton)
	
	# TODO: Make this only visible when the Item is consumeable
	useButton = Button.new()
	useButton.text = "Consume"
	useButton.pressed.connect(useItemOnOwner)
	useButton.add_theme_font_size_override("button_font_size", 10)
	vBoxContainer.add_child(useButton)

	removeButton = Button.new()
	removeButton.text = "Remove One"
	removeButton.pressed.connect(removeOneItem)
	removeButton.add_theme_font_size_override("button_font_size", 10)
	vBoxContainer.add_child(removeButton)

	removeAllButton = Button.new()
	removeAllButton.text = "Remove All"
	removeAllButton.pressed.connect(removeAllItems)
	removeAllButton.add_theme_font_size_override("button_font_size", 10)
	vBoxContainer.add_child(removeAllButton)

func removeOneItem() -> void:
	var slotData := inventoryData.slotDatas[index]
	slotData.quantity -= 1
	if slotData.quantity < 1:
		inventoryData.slotDatas[index] = null
		hide()
	inventoryData.inventoryUpdated.emit(inventoryData)

func removeAllItems() -> void:
	inventoryData.slotDatas[index] = null
	hide()
	inventoryData.inventoryUpdated.emit(inventoryData)

func useItemOnOwner() -> void:
	var slotData := inventoryData.slotDatas[index]
	var owner := inventoryData.owner
	slotData.itemData.useOnCharacter(owner)
	removeOneItem()
	

func setOptions(_inventoryData: InventoryData, _index: int) -> bool:
	# TODO: Implement Item Data and show Options
	inventoryData = _inventoryData
	index = _index
	var slotData := inventoryData.slotDatas[index]
	if not slotData:
		return false
	var itemData := slotData.itemData
	#...
	return true
	

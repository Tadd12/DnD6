extends PanelContainer
class_name ItemOptions

var infoButton : Button
var useButton : Button
var equipButton: Button
var removeButton : Button
var removeAllButton : Button
var inventoryData: InventoryData
var index: int

@onready var vBoxContainer := $VBoxContainer

func _ready():
	infoButton = Button.new()
	infoButton.text = "Info"
	infoButton.add_theme_font_size_override("button_font_size", 10)
	
	useButton = Button.new()
	useButton.text = "Consume"
	useButton.pressed.connect(useItemOnOwner)
	useButton.add_theme_font_size_override("button_font_size", 10)
	vBoxContainer.add_child(useButton)

	equipButton = Button.new()
	equipButton.text = "Equip"
	equipButton.add_theme_font_size_override("button_font_size", 10)
	
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
	for button in vBoxContainer.get_children():
		vBoxContainer.remove_child(button)
	inventoryData = _inventoryData
	index = _index
	var slotData := inventoryData.slotDatas[index]
	if not slotData:
		return false
	var itemData := slotData.itemData

	vBoxContainer.add_child(infoButton)
	
	if itemData is ArmorBase or itemData is WeaponBase:
		vBoxContainer.add_child(equipButton)
	if itemData is ConsumableBase:
		vBoxContainer.add_child(useButton)
	vBoxContainer.add_child(removeButton)
	if itemData.stackable and slotData.quantity > 1:
		vBoxContainer.add_child(removeAllButton)
	reset_size()
		
	return true
	
func _exit_tree() -> void:
	infoButton.queue_free()
	useButton.queue_free()
	equipButton.queue_free()
	removeButton.queue_free()
	removeAllButton.queue_free()

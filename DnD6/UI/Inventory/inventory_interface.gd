extends Control
class_name InventoryInterface

var grabbedSlotData: SlotData
var externalInventoryOwner

@onready var playerInventory := $PlayerInventory as Inventory
@onready var grabbedSlot := $GrabbedSlot as Slot
@onready var externalInventory := $ExternalInventory as Inventory
@onready var itemOptions := $ItemOptions as ItemOptions

func _physics_process(_delta: float) -> void:
	if grabbedSlot.visible:
		grabbedSlot.global_position = get_global_mouse_position() + Vector2(5, 5)


## Sets the player inventory view to [param inventoryData]
func setPlayerInventory(inventoryData: InventoryData) -> void:
	inventoryData.inventoryInteract.connect(onInventoryInteract)
	playerInventory.setInventoryData(inventoryData)

	
## Sets the external inventory view to the inventory owned by [param _externalInventoryOwner]
func setExternalInventory(_externalInventoryOwner) -> void:
	if externalInventoryOwner == _externalInventoryOwner:
		return
	externalInventoryOwner = _externalInventoryOwner
	var inventoryData = externalInventoryOwner.inventoryData
	
	inventoryData.inventoryInteract.connect(onInventoryInteract)
	externalInventory.setInventoryData(inventoryData)

	externalInventory.show()

	
## Clears the external inventory view and removes the refrence to the external owner
func clearExternalInventory() -> void:
	if externalInventoryOwner:
		var inventoryData = externalInventoryOwner.inventoryData
		
		inventoryData.inventoryInteract.disconnect(onInventoryInteract)
		externalInventory.clearInventoryData(inventoryData)
		
		externalInventory.hide()
		externalInventoryOwner = null

func showItemOptions(inventoryData: InventoryData, index: int) -> void:
	if not itemOptions.setOptions(inventoryData, index):
		itemOptions.hide()
		return
	itemOptions.show()
	itemOptions.global_position = get_global_mouse_position() + Vector2(5, 5)	

## Gets called when the mouse interacts with a slot
func onInventoryInteract(inventoryData: InventoryData, index: int, button: int, doubleClicked: bool) -> void:
	
	if itemOptions.visible:
		itemOptions.hide()
	
	match [grabbedSlotData, button]:
		[null, MOUSE_BUTTON_LEFT]:
			if Input.is_physical_key_pressed(KEY_SHIFT) \
					and externalInventoryOwner:
				# TODO: Implement to send the item to the other inventory
				pass
			else:
				grabbedSlotData = inventoryData.grabSlotData(index)
		[_, MOUSE_BUTTON_LEFT]:
			if not doubleClicked:
				grabbedSlotData = inventoryData.dropSlotData(grabbedSlotData, index)
			else:
				grabbedSlotData = inventoryData.mergeAllSlotData(grabbedSlotData)
		[null, MOUSE_BUTTON_RIGHT]:
			if Input.is_physical_key_pressed(KEY_SHIFT):
				grabbedSlotData = inventoryData.grabHalfSlotData(index)
			else:
				showItemOptions(inventoryData, index)
		[_, MOUSE_BUTTON_RIGHT]:
			grabbedSlotData = inventoryData.dropSingleSlotData(grabbedSlotData, index)
		
	updateGrabbedSlot()

## Toggles the visibility of the slot for a grabbed item
func updateGrabbedSlot() -> void:
	if grabbedSlotData:
		grabbedSlot.show()
		grabbedSlot.setSlotData(grabbedSlotData)
	else:
		grabbedSlot.hide()

#TODO: Make it so the item in the grabbedSlot is put into an inventory
func dropGrabbedSlot() -> void:
	if not grabbedSlot.visible:
		return
	
	

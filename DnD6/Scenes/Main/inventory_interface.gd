extends Control

var grabbedSlotData: SlotData
var externalInventoryOwner

@onready var playerInventory := $PlayerInventory
@onready var grabbedSlot := $GrabbedSlot
@onready var externalInventory := $ExternalInventory
 
func _physics_process(_delta: float) -> void:
	if grabbedSlot.visible:
		grabbedSlot.global_position = get_global_mouse_position() + Vector2(5, 5)


#desc Sets the player inventory view to [param inventoryData]
func set_playerInventory(inventoryData: InventoryData) -> void:
	inventoryData.inventoryInteract.connect(onInventoryInteract)
	playerInventory.setInventoryData(inventoryData)

	
#desc Sets the external owner inventory view to the inventory owned by [param _externalInventoryOwner]
func set_externalInventory(_externalInventoryOwner) -> void:
	if externalInventoryOwner == _externalInventoryOwner:
		return
	externalInventoryOwner = _externalInventoryOwner
	var inventoryData = externalInventoryOwner.inventoryData
	
	inventoryData.inventoryInteract.connect(onInventoryInteract)
	externalInventory.setInventoryData(inventoryData)

	externalInventory.show()

	
#desc Clears the external inventory view and removes the refrence to the external owner
func clear_externalInventory() -> void:
	if externalInventoryOwner:
		var inventoryData = externalInventoryOwner.inventoryData
		
		inventoryData.inventoryInteract.disconnect(onInventoryInteract)
		externalInventory.clearInventoryData(inventoryData)
		
		externalInventory.hide()
		externalInventoryOwner = null

		
#desc Gets called when the mouse interacts with a slot
func onInventoryInteract(inventoryData: InventoryData, index: int, button: int, double: bool) -> void:

	match [grabbedSlotData, button]:
		[null, MOUSE_BUTTON_LEFT]:
			if Input.is_physical_key_pressed(KEY_SHIFT) \
					and externalInventoryOwner:
				pass
			else:
				grabbedSlotData = inventoryData.grabSlotData(index)
		[_, MOUSE_BUTTON_LEFT]:
			if not double:
				grabbedSlotData = inventoryData.dropSlotData(grabbedSlotData, index)
			else:
				grabbedSlotData = inventoryData.mergeAllSlotData(grabbedSlotData)
		[null, MOUSE_BUTTON_RIGHT]:
			if Input.is_physical_key_pressed(KEY_SHIFT):
				grabbedSlotData = inventoryData.grabHalfSlotData(index)
			else:
				pass
		[_, MOUSE_BUTTON_RIGHT]:
			grabbedSlotData = inventoryData.drop_single_slotData(grabbedSlotData, index)
		
	update_grabbedSlot()

#desc Toggles the visibility of the slot for a grabbed item
func update_grabbedSlot() -> void:
	if grabbedSlotData:
		grabbedSlot.show()
		grabbedSlot.setSlotData(grabbedSlotData)
	else:
		grabbedSlot.hide()

func drop_grabbedSlot() -> void:
	if not grabbedSlot.visible:
		return
	
	

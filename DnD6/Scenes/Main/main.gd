extends Node

@onready var player := $Game/Player as Player
@onready var inventoryInterface := $UI/InventoryInterface as InventoryInterface
@onready var dialogView := $UI/DialogView as DialogView


func _ready() -> void:
	setupInventorySystem()
	setupDialogSystem()
	
	
func setupInventorySystem() -> void:
	player.toggleInventory.connect(toggleInventoryInterface)
	player.inventoryData.owner = player
	inventoryInterface.setPlayerInventory(player.inventoryData)
	player.closeUi.connect(_closeUi)
	for node in get_tree().get_nodes_in_group("externalInventory"):
		node.toggleInventory.connect(toggleInventoryInterface)
	
	
func setupDialogSystem() -> void:
	for node in get_tree().get_nodes_in_group("npc") as Array[NpcBase]:
		node.startDialog.connect(makeDialog)
		


func _closeUi() -> void:
	if inventoryInterface.visible:
		toggleInventoryInterface()


#desc Toggles the visibility of the inventory interface.
#desc If an [param externalInventoryOwner] is provided, an additional inventory will open to display the contens.
#desc If [param keepOpen] is provided and the inventory is visible, it will stay visible.
func toggleInventoryInterface(externalInventoryOwner = null, keepOpen = false) -> void:
	if inventoryInterface.visible and keepOpen:
		pass
	else:
		inventoryInterface.visible = not inventoryInterface.visible
	
	
	if inventoryInterface.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		inventoryInterface.dropGrabbedSlot()
	
	if externalInventoryOwner and inventoryInterface.visible:
		inventoryInterface.setExternalInventory(externalInventoryOwner)
	else:
		inventoryInterface.clearExternalInventory()

	
	
func makeDialog(dialogName: String, startIndex: int, npc: NpcBase) -> void:
	_closeUi()
	dialogView.createView(player.icon, dialogName, npc.icon, startIndex)
	dialogView.questionAnswered.connect(npc.dialogCallback)
	dialogView.questionAnswered.connect(func(_code, finished):
		if finished:
			player.moveable = true
	)
	dialogView.startConversation()
	player.moveable = false

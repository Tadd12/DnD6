extends Node

@onready var player := $Game/Player as Player
@onready var inventoryInterface := $UI/InventoryInterface as InventoryInterface
@onready var dialogueView := $UI/DialogueView as DialogueView


func _ready() -> void:
	setupInventorySystem()
	setupDialogSystem()
	GlobalGameState.player = player
	

## Connects all signals for the inventory system
func setupInventorySystem() -> void:
	player.toggleInventory.connect(toggleInventoryInterface)
	player.inventoryData.owner = player
	inventoryInterface.setPlayerInventory(player.inventoryData)
	player.closeUi.connect(_closeUi)
	for node in get_tree().get_nodes_in_group("externalInventory"):
		node.toggleInventory.connect(toggleInventoryInterface)
	
	
	
## Connects all signals for the dialog system
func setupDialogSystem() -> void:
	for node in get_tree().get_nodes_in_group("npc") as Array[NpcBase]:
		node.startDialog.connect(_makeDialog)
		


func _closeUi() -> void:
	if inventoryInterface.visible:
		toggleInventoryInterface()


## Toggles the visibility of the inventory interface.
## If an [param externalInventoryOwner] is provided, an additional inventory will open to display the contens.
## If [param keepOpen] is provided and the inventory is visible, it will stay visible.
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

	
	
## Starts a the dialog between the player and the npc
func _makeDialog(dialogueName: String, start: String, npc: NpcBase) -> void:
	_closeUi()
	dialogueView.customSignal.connect(npc._onDialogSignal)
	dialogueView.createView(player.icon, dialogueName, npc.icon, start)
	

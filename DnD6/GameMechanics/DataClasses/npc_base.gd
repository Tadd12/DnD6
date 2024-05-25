extends CharacterBase
class_name NpcBase
## Special class for Npcs

signal startDialog(dialogName: String, startIndex: int, npc: NpcBase)

@export var dialogueName: String
@export var dialogueStart := "start"

## Executed when the Player interacts with Npc
func playerInteract():
	startDialog.emit(dialogueName, dialogueStart, self)
	
	
## This function is called when the dialog emits a custom signal.
## This function should handle all possible signals in the dialog
func _onDialogSignal(value) -> void:
	## Replace with dialog logic (optional)
	pass
	

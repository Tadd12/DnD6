extends CharacterBase
class_name NpcBase
## Special class for Npcs

signal startDialog(dialogName: String, startIndex: int, npc: NpcBase)

@export var dialogueName: String
@export var dialogueStart := "start"

## Executed when the Player interacts with Npc
func playerInteract():
	startDialog.emit(dialogueName, dialogueStart, self)
	
	
## This function is called when the dialog gives a callback code.
## This function should handle all possible codes in the dialog
func _dialogCallback(code: int, dialogFinished: bool) -> void:
	## Replace with dialog logic (optional)
	pass
	

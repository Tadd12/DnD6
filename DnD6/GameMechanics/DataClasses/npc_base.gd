extends CharacterBase
class_name NpcBase
## Special class for Npcs

signal startDialog(dialogName: String, npc: NpcBase)

@export var dialogName: String

## Executed when the Player interacts with Npc
func playerInteract():
	startDialog.emit(dialogName, self)
	
	
## This function is called when the dialog gives a callback code.
## This function should handle all possible codes in the dialog
func dialogCallback(code: int, dialogFinished: bool) -> void:
	pass
	

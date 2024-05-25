extends Control
class_name DialogueView

@onready var characterIconLeft := $HBoxContainer/IconLeft
@onready var characterIconRight := $HBoxContainer/IconRight
@onready var conversationText := $HBoxContainer/VBoxContainer/HBoxContainer2/TextBox
@onready var buttonBox := $HBoxContainer/VBoxContainer/HBoxContainer/ButtonBox
@onready var ezDialogue := $EzDialogue

var answerButton := preload("res://UI/Dialog/answer_button.tscn")
var buttons: Array[Button] = []

var currentResponse: DialogueResponse

## Sets a new dialogue and icons.
## To start the set dialogue, call startConversation()
func createView(iconLeft: Texture2D, dialogueName: String, iconRight:Texture2D, dialogueBegin:String="start") -> void:
	characterIconLeft.texture = iconLeft
	characterIconRight.texture = iconRight
	var dialogueFile: JSON = load("res://Dialogue/{0}.json".format([dialogueName]))
	startConversation()
	ezDialogue.start_dialogue(dialogueFile, GlobalGameState.state, dialogueBegin)
	
## Starts the created conversation with the given dialog
func startConversation() -> void:
	set_visible(true)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	GlobalGameState.player.moveable = false
	
	
## Function to end the dialog.
## Emits the dialogFinished signal
func endConversation() -> void:
	print_debug("Dialog Finsihed")
		
	set_visible(false)
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	GlobalGameState.player.moveable = true
	

	
## Gets called by the Timer Node to increment the characters currently shown
## Once all characters are shown, it calls the _addAnswers() function
func _incrementText() -> void:
	if conversationText.get_visible_characters() < conversationText.text.length():
		conversationText.set_visible_characters(conversationText.get_visible_characters() + 4)
	else:
		$TextTimer.stop()
		_addAnswers()
	

## Internal function to reset the answer buttons and start displaying new text
func _setNextText() -> void:
	for button in buttons:
		button.queue_free()
	buttons = []
	conversationText.set_visible_characters(0)
	conversationText.text = currentResponse.text
	$TextTimer.start()


## Internal function to display answers
func _addAnswers() -> void:
	if currentResponse.eod_reached:
		endConversation()
		return
	
	if currentResponse.choices.is_empty():
		currentResponse.choices.append("...")
	
	for answer in currentResponse.choices:
		var butt: AnswerButton = answerButton.instantiate()
		butt.index = buttons.size()
		butt.text = answer
		butt.answerSelected.connect(_selectAnswer)
		buttons.append(butt)
		buttonBox.add_child(butt)


## Internal function that gets called by the Buttons to submit the index
func _selectAnswer(index: int):
	ezDialogue.next(index)
	
	
func _onDialogGenerated(response: DialogueResponse):
	currentResponse = response
	_setNextText()

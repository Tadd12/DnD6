extends Control
class_name DialogView

@onready var characterIconLeft := $CharacterIconLeft
@onready var characterIconRight := $CharacterIconRight
@onready var conversationText := $ConversationText
@onready var buttons: Array[Button] = [$AnswerButton1, $AnswerButton2, $AnswerButton3]

## When set to true it will call the test dialog
@export var testDialog := false

signal questionAnswered(code: int, finished: bool)

var dialog: Dialog = null

var piece: DialogPiece

var textRendered := false

var moreDialog := true

## Sets a new dialog and icons.
## To start the set dialog, call startConversation()
func createView(iconLeft: Texture2D, dialogName: String, iconRight:Texture2D=null, dialogBegin:int=0) -> void:
	characterIconLeft.texture = iconLeft
	characterIconRight.texture = iconRight
	dialog = Dialog.new(dialogName, dialogBegin)
	
	
## Starts the created conversation with the given dialog
func startConversation() -> void:
	set_visible(true)
	_setNextText()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	
## Function to end the dialog.
## Emits the dialogFinished signal
func endConversation() -> void:
	print_debug("Dialog Finsihed")
		
	set_visible(false)
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	questionAnswered.emit(dialog.nextId, true)
	
	for conn in questionAnswered.get_connections():
		questionAnswered.disconnect(conn["callable"])

	
## Gets called by the Timer Node to increment the characters currently shown
## Once all characters are shown, it calls the _addAnswers() function
func _incrementText() -> void:
	if conversationText.get_visible_characters() < conversationText.text.length():
		conversationText.set_visible_characters(conversationText.get_visible_characters() + 1)
	else:
		$TextTimer.stop()
		_addAnswers()
	

## Internal function to reset the answer buttons and start displaying new text
func _setNextText() -> void:
	buttons.map(func(butt: Button): butt.set_visible(false))
	piece = dialog.getNext()
	conversationText.set_visible_characters(0)
	conversationText.text = piece.text
	$TextTimer.start()


## Internal function to display answers
func _addAnswers() -> void:
	if piece.answers.is_empty():
		endConversation()

	for index in piece.answers.size():
		var butt := buttons[index]
		butt.set_visible(true)
		butt.text = piece.answers[index]


## Internal function that gets called by the Buttons to submit the index
func _selectAnswer(index: int):
	dialog.selectAnswer(index)
	# TODO: Add codes to answers that impact something. 0 is a placeholder
	questionAnswered.emit(0, false)
	_setNextText()
	
	
func _ready() -> void:
	if testDialog:
		createView(null, "test")
		startConversation()


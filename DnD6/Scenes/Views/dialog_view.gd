extends Control

@onready var characterIconLeft := $CharacterIconLeft
@onready var characterIconRight := $CharacterIconRight
@onready var conversationText := $ConversationText
@onready var buttons: Array[Button] = [$AnswerButton1, $AnswerButton2, $AnswerButton3, $AnswerButton4]

@export var test := false

signal dialogFinished(returnCode: int)
signal questionAnswered(code: int)

var dialog: Dialog = null

var piece: Dialog.DialogPiece

var textRendered := false

var moreDialog := true

func createView(iconLeft: Texture2D, dialogName: String, iconRight:Texture2D=null) -> void:
	characterIconLeft.texture = iconLeft
	characterIconRight.texture = iconRight
	dialog = Dialog.new(dialogName)
	
	
func startConversation() -> void:
	set_visible(true)
	_setNextText()
	
func endConversation() -> void:
	print_debug("Dialog Finsihed")
	set_visible(false)
	dialogFinished.emit(dialog.nextId)

	
func _incrementText() -> void:
	if conversationText.get_visible_characters() < conversationText.text.length():
		conversationText.set_visible_characters(conversationText.get_visible_characters() + 1)
	else:
		$TextTimer.stop()
		_addAnswers()
	
		
func _setNextText() -> void:
	buttons.map(func(butt: Button): butt.set_visible(false))
	piece = dialog.getNext()
	conversationText.set_visible_characters(0)
	conversationText.text = piece.text
	$TextTimer.start()

	
func _addAnswers() -> void:
	if piece.answers.is_empty():
		moreDialog = false

	for index in piece.answers.size():
		var butt := buttons[index]
		butt.set_visible(true)
		butt.text = piece.answers[index]

		
func _selectAnswer(index: int):
	dialog.selectAnswer(index)
	# TODO: Add codes to answers that impact something. 0 is a placeholder
	questionAnswered.emit(0)
	_setNextText()

	
func _gui_input(event: InputEvent) -> void:
	if not moreDialog:
		endConversation()
	if not event.is_pressed():
		return
	accept_event()
	
func _ready() -> void:
	if test:
		createView(null, "test")
		startConversation()


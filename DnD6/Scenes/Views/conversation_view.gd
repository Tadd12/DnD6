extends Control

@onready var characterIconLeft := $CharacterIconLeft
@onready var characterIconRight := $CharacterIconRight
@onready var conversationText := $ConversationText
@onready var textTimer := $TextTimer

@export var test := false

var conversationTree: ConversationTree = null

var textRendered := false

func createView(iconLeft: Texture2D, conversationPath: String, iconRight:Texture2D=null) -> void:
	characterIconLeft.texture = iconLeft
	characterIconRight.texture = iconRight
	conversationTree = ConversationTree.new(conversationPath)
	
	
func startConversation() -> void:
	set_visible(true)
	setText(conversationTree.getNext())
	_incrementText()
	
func addAnswers() -> void:
	# TODO: Add clickable answers
	if not conversationTree.answerable:
		return
	pass

func _incrementText() -> void:
	if conversationText.get_visible_characters() < conversationText.text.length():
		conversationText.set_visible_characters(conversationText.get_visible_characters() + 1)
		textTimer.start()
	else:
		addAnswers()
		textRendered = true
	
	
func setText(text: String) -> void:
	conversationText.set_visible_characters(0)
	textRendered = false
	conversationText.text = text
	

func endConversation() -> void:
	set_visible(false)
	
func _unhandled_input(event: InputEvent) -> void:
	if textRendered:
		setText(conversationTree.getNext())
	
func _ready() -> void:
	if test:
		createView(null, "")
		startConversation()

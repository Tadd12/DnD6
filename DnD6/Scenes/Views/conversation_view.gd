extends Control

@onready var characterIconLeft := $CharacterIconLeft
@onready var characterIconRight := $CharacterIconRight
@onready var conversationText := $ConversationText
@onready var textTimer := $TextTimer

signal textFinishedRendering()

var conversationTree: ConversationTree = null
var waiting := false

func createView(_iconLeft: Texture2D, _conversationTree: ConversationTree, _iconRight:Texture2D=null) -> void:
	characterIconLeft.texture = _iconLeft
	characterIconRight.texture = _iconRight
	conversationTree = _conversationTree
	
	
func startConversation() -> void:
	setText(conversationTree.getNext())
	incrementText()
	
func addAnswers():
	# TODO: Add clickable answers
	if not conversationTree.answerable:
		return
	pass

func incrementText() -> void:
	if conversationText.get_visible_characters() < conversationText.text.length():
		conversationText.set_visible_characters(conversationText.get_visible_characters() + 1)
		textTimer.start()
	else:
		textFinishedRendering.emit()
	
	
func setText(text: String) -> void:
	conversationText.set_visible_characters(0)
	
	conversationText.text = text
	

func endConversation() -> void:
	pass

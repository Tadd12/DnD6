class_name ConversationTree

var currentIndex := 0
var text := ""
var answerable := false
var answers : Dictionary = {}
var conversation : Array[Variant]

func _init(path: String):
	loadConversation(path)

func loadConversation(path: String) -> ConversationTree:
	# TODO: Load Conversation from path
	conversation = [
		"Text",
		"?Question",
		{
			"Answer1" : 2,
			"Answer2" : 3,
			"Answer3" : 4
		},
	]
	return self

func getNext() -> Variant:
	if currentIndex > conversation.size():
		return null
	assert(currentIndex != -1, "Text requested while waiting for an answer. " +
		"Remember to call acceptAnswer with the given answer")
	assert(not conversation[currentIndex] is Dictionary, "The current index points to an answer " +
		"dict. Check if the Question was prefixed with '?' and that no answer points to an answer dict")
	var value: String = conversation[currentIndex]
	answerable = value.begins_with("?")
	if answerable:
		value = value.substr(1)
		answers = conversation[currentIndex + 1]
		currentIndex = -1
	else:
		currentIndex += 1
	text = value
	return value

func acceptAnswer(id: int) -> void:
	currentIndex = id

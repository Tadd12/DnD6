extends RefCounted
class_name Dialog

var nextId: int
var possibleNextIds: Array
var questions: Array
var answers: Array

## Creates a new Dialog from the given name
func _init(dialogName: String, dialogBeginId: int = 0):
	_loadDialogFromFile(dialogName)
	nextId = dialogBeginId


## loads the dialog from a file
## checks the if the dialog has the correct format
func _loadDialogFromFile(dialogName: String) -> void:
	var file := "res://Dialog/{0}.json".format([dialogName])
	var file_access := FileAccess.open(file, FileAccess.READ)
	assert (file_access != null, "Could not read the dialog file at {0}".format([file]))
	var json_string := file_access.get_line()
	file_access.close() # optional

	var data = JSON.parse_string(json_string)
	assert (data != null, "Could not read the contents of the dialog file at {0}".format([file]))
	assert (data is Array)

	questions = Dictionary(data[0]).values()
	answers = Dictionary(data[1]).values()

## Returns a [DialogPiece] that contains the next Question and Answers
## The index needs to be cahgned by calling selectAnswer to recieve a new [DialogPiece]
func getNext() -> DialogPiece:
	var text: String = questions[nextId][0]
	var answerIds: Array = questions[nextId][1]
	var newAnswers: Array[String]  = []

	for id in answerIds:
		newAnswers.append(answers[id][0])
		possibleNextIds.append(answers[id][1])

	return DialogPiece.new(text, newAnswers)

## Recieves the answer and sets the index for getNext()
func selectAnswer(answerIndex: int) -> void:
	nextId = possibleNextIds[answerIndex]
	possibleNextIds = []

class_name Dialog

var nextId: int
var possibleNextIds: Array
var questions: Array
var answers: Array

func _init(dialogName: String, dialogBeginId: int = 0):
	_loadDialogFromFile(dialogName)
	nextId = dialogBeginId


## loads the Dialog from a file
## checks the if the dialog has the correct format
func _loadDialogFromFile(dialogName: String) -> void:
	var file := "res://Dialog/{0}.json".format([dialogName])
	var file_access := FileAccess.open(file, FileAccess.READ)
	assert (file_access != null, "Could not read the dialog file at {0}".format([file]))
	var json_string := file_access.get_line()
	file_access.close() # optional#
	
	var data = JSON.parse_string(json_string)
	assert (data != null, "Could not read the contents of the dialog file at {0}".format([file]))
	assert (data is Array)
	
	questions = Dictionary(data[0]).values()
	answers = Dictionary(data[1]).values()


func getNext() -> DialogPiece:
	var text: String = questions[nextId][0]
	var answerIds: Array = questions[nextId][1]
	var newAnswers: Array[String]  = []
	
	for id in answerIds:
		newAnswers.append(answers[id][0])
		possibleNextIds.append(answers[id][1])
	
	return DialogPiece.new(text, newAnswers)

		
func selectAnswer(answerIndex: int) -> void:
	nextId = possibleNextIds[answerIndex]
	possibleNextIds = []
	
class DialogPiece:
	var text: String
	var answers: Array[String]
	func _init(text, answers):
		self.text = text
		self.answers = answers

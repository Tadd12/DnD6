extends Button
class_name AnswerButton

signal answerSelected(index: int)

var index: int


func _onPressed():
	answerSelected.emit(index)
	

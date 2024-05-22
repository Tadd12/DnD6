extends RefCounted
class_name DialogPiece

var text: String
var answers: Array[String]

## A Dataclass that holds a question and an [Array] of answers
func _init(text, answers):
    self.text = text
    self.answers = answers
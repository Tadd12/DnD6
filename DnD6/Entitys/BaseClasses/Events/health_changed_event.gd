class_name HealthChangedEvent

var oldHealth: float:
var newHealth: float
var changeValue: float
var entity
var causeOfChange


func _init(old: float, new: float, amount: float, reciever, cause):
    oldHealth = old
    newHealth = new
    changeValue = amount
    entity = reciever
    causeOfChange = cause

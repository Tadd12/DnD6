class_name HealthChangedEvent

var old_health: float
var new_health: float
var change_value: float
var entity
var cause_of_change


func _init(old: float, new: float, amount: float, reciever, cause):
	old_health = old
	new_health = new
	change_value = amount
	entity = reciever
	cause_of_change = cause
	
func get_cause():
	return cause_of_change
   
func get_entity():
	return entity

func get_old_hp() -> float:
	return old_health
	
func get_new_hp() -> float:
	return new_health
	
func get_amount() -> float:
	return change_value
	

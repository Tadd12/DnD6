extends Node2D



var inventory := {}


func set_contens(items:Dictionary):
	inventory = items.duplicate(true)
				
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_interact_area_entered(area: Area2D):
	
	pass # Replace with function body.

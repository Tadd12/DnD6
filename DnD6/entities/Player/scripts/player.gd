extends CharacterBase

@export var speed := 200
@onready var interact_area := $InteractArea


signal toggle_inventory
signal close_ui

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Player ready")


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()
	
	if Input.is_action_just_pressed("ui_cancel"):
		close_ui.emit()
		
	if Input.is_action_just_pressed("interact"):
		interact()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var vel := Vector2.ZERO
	if Input.is_action_pressed("up"):
		vel.y -= 1
	if Input.is_action_pressed("down"):
		vel.y += 1
	if Input.is_action_pressed("left"):
		vel.x -= 1
	if Input.is_action_pressed("right"):
		vel.x += 1
	velocity = vel.normalized() * speed
	move_and_slide()
	

#desc Checks if there is an interactable body within the [InteractArea].
#desc If bodys are found, the [code]player_interact[/code] method is called on the closest one.
func interact() -> void:
	if interact_area.get_overlapping_bodies():
		var closest = interact_area.get_overlapping_bodies() \
			.map(func(body): 
				return body.get_global_position().distance_to(get_global_position())) \
			.min()
		interact_area.get_overlapping_bodies()[0].player_interact()

extends Control

var animationFinished = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/AnimationPlayer.play("TextDisplay")
	$MarginContainer/AnimationPlayer.animation_finished.connect(onAnimationFinished)

# Called when an input event is received
func _input(event):
	# check if enter is pressed
	if event is InputEventKey and event.pressed:
		if animationFinished:
			get_tree().change_scene_to_file("res://Scenes/Main/main.tscn")
			return
		# stop animation
		$MarginContainer/AnimationPlayer.seek($MarginContainer/AnimationPlayer.current_animation_length, true)
		animationFinished = true

	# check if mouse is clicked
	if event is InputEventMouseButton and event.pressed:
		if animationFinished:
			get_tree().change_scene_to_file("res://Scenes/Main/main.tscn")
			return
		# stop animation
		$MarginContainer/AnimationPlayer.seek($MarginContainer/AnimationPlayer.current_animation_length, true)
		animationFinished = true

# function is called when animation is finished
func onAnimationFinished():
	animationFinished = true

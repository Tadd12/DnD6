extends Control

var animation_finished = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/AnimationPlayer.play("TextDisplay")
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if $MarginContainer/AnimationPlayer.is_playing() == false and animation_finished == false:
		# Rufe die Funktion auf, wenn die Animation beendet ist
		_on_animation_finished()

# Called when an input event is received
func _input(event):
	# Prüfe, ob die Enter-Taste gedrückt wurde
	if event is InputEventKey and event.pressed:
		if animation_finished:
			get_tree().change_scene_to_file("res://Scenes/Main/main.tscn")
			return
		# Stoppe die Animation im AnimationPlayer
		$MarginContainer/AnimationPlayer.seek($MarginContainer/AnimationPlayer.current_animation_length, true)
		animation_finished = true

	# Prüfe, ob die Maus geklickt wurde
	if event is InputEventMouseButton and event.pressed:
		if animation_finished:
			get_tree().change_scene_to_file("res://Scenes/Main/main.tscn")
			return
		# Stoppe die Animation im AnimationPlayer
		$MarginContainer/AnimationPlayer.seek($MarginContainer/AnimationPlayer.current_animation_length, true)
		animation_finished = true

# Funktion, die aufgerufen wird, wenn die Animation beendet ist
func _on_animation_finished():
	animation_finished = true

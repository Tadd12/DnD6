extends Sprite2D

const speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	print("ready")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	return
	var d_speed = speed * delta
	if Input.is_key_pressed(KEY_W):
			position += Vector2.UP * d_speed
	if Input.is_key_pressed(KEY_A):
			position += Vector2.LEFT * d_speed
	if Input.is_key_pressed(KEY_S):
			position += Vector2.DOWN * d_speed
	if Input.is_key_pressed(KEY_D):
			position += Vector2.RIGHT * d_speed
			

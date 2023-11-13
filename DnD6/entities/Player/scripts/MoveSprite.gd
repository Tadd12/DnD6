extends Sprite2D

const speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	print("ready")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	return
	var dSpeed = speed * delta
	if Input.is_key_pressed(KEY_W):
			position += Vector2.UP * dSpeed
	if Input.is_key_pressed(KEY_A):
			position += Vector2.LEFT * dSpeed
	if Input.is_key_pressed(KEY_S):
			position += Vector2.DOWN * dSpeed
	if Input.is_key_pressed(KEY_D):
			position += Vector2.RIGHT * dSpeed
			

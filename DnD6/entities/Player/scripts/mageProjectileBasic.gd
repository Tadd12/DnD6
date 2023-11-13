extends Node2D


var timeToLive = 2
var timeLived = 0
var speed = 200
var accelMult = 4
var timeToAccel = 0.5
var damage = 5

@onready var animatedSprite2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sprite: Sprite2D = $Sprite

func setup(speed, timeToLive, damage):
	self.speed = speed
	self.timeToLive = timeToLive
	self.damage = damage

# Called when the node enters the scene tree for the first time.
func _ready():
	animatedSprite2d.set_visible(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	timeLived += delta

	if not sprite.visible:
		return

	if timeLived >= timeToLive:
		explosionAnimation()

	var rot = transform.get_rotation()
	var factor = delta * speed
	if timeLived > timeToAccel:
		factor *= accelMult
	position += Vector2.from_angle(rot) * factor


func explosionAnimation():
	sprite.set_visible(false)
	animatedSprite2d.set_visible(true)
	animatedSprite2d.play("explosion")



func _onAnimatedAprite2dAnimationFinished():
	animatedSprite2d.stop()
	queue_free()

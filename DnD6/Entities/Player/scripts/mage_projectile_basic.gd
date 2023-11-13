extends Node2D


var time_to_live = 2
var time_lived = 0
var speed = 200
var accel_mult = 4
var time_to_accel = 0.5
var damage = 5

@onready var animated_sprite2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sprite: Sprite2D = $Sprite

func setup(speed, time_to_live, damage):
	self.speed = speed
	self.time_to_live = time_to_live
	self.damage = damage

# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite2d.set_visible(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	time_lived += delta

	if not sprite.visible:
		return

	if time_lived >= time_to_live:
		explosion_animation()

	var rot = transform.get_rotation()
	var factor = delta * speed
	if time_lived > time_to_accel:
		factor *= accel_mult
	position += Vector2.from_angle(rot) * factor


func explosion_animation():
	sprite.set_visible(false)
	animated_sprite2d.set_visible(true)
	animated_sprite2d.play("explosion")



func _on_animated_sprite_2d_animation_finished():
	animated_sprite2d.stop()
	queue_free()

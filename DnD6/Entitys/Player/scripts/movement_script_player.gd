extends CharacterBase

var speed            := 200
var Direction        := "Left"
var basic_projectile := preload("res://Entitys/Player/mage_projectile_basic.tscn")
@onready var player_sprite: Sprite2D = $PlayerSprite
@export var test := 2

@export var showInventory:ShowInventory 
@export var inventory:BaseInventory


func _init():
	super('Bluera', 0, 0, 0, 0, 0, 0, {}, '', 20)
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Ready")
	inventory.add_itemlist([
		load("res://Items/Apple/apple.tscn").instantiate(),
		load("res://Items/HealthPotion/health_potion.tscn").instantiate()
	])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("attack"):
		var p : Node2D = basic_projectile.instantiate()
		p.set_position(position)
		var mouse_pos := get_local_mouse_position()
		p.rotate(mouse_pos.angle())
		add_sibling(p)
		
	if Input.is_action_just_pressed("inventory"):
		showInventory.toggle_inventory()
	
	
	var pos := Vector2.ZERO
	if Input.is_action_pressed("up"):
		pos.y -= speed * delta
	if Input.is_action_pressed("down"):
		pos.y += speed * delta
	if Input.is_action_pressed("left"):
		pos.x -= speed * delta
	if Input.is_action_pressed("right"):
		pos.x += speed * delta

	if pos.x > 0 and Direction == "Left":
		player_sprite.set_flip_h(true)
		Direction = "Right"
	elif pos.x < 0 and Direction == "Right":
		player_sprite.set_flip_h(false)
		Direction = "Left"
	
	position += pos



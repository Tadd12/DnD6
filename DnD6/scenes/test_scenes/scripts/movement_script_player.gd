extends CharacterBase

var speed = 200
var Direction = "Left"
var basic_projectile = preload("res://scenes/test_scenes/mage_projectile_basic.tscn")
@onready var player_sprite: Sprite2D = $PlayerSprite


var inventoryOpen = false

func _init():
	super('Bluera', 0, 0, 0, 0, 0, 0, {}, '', 20)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Ready")
	self.inventory = [ItemBase.new("HealthPotion", 0.1, null, "res://Sprites//HealthPosionW20.png"),
					  ItemBase.new("Sword", 1.0),
					  preload("res://Items/Apple.gd").new()]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not inventoryOpen:
		if Input.is_action_just_pressed("attack"):
			var p : Node2D = basic_projectile.instantiate()
			p.set_position(position)
			var mouse_pos = get_local_mouse_position()
			p.rotate(mouse_pos.angle())
			add_sibling(p)

		if Input.is_action_just_pressed("inventory"):
			self._openInventory()
		var pos = Vector2.ZERO
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
	else:
		if Input.is_action_just_pressed("inventory"):
			self._closeInventory()
		
		


func _openInventory():
	inventoryOpen = true
	var rootNode = get_node("/root").get_child(0)
	var inventoryScene = load("res://scenes/test_scenes/GuiInventory.tscn").instantiate()
	inventoryScene.get_child(1)._setItems(self.inventory)
	rootNode.add_child(inventoryScene)

func _closeInventory():
	var inventoryScene = $"../GuiInventory"
	var root = get_parent()
	root.remove_child(inventoryScene)
	inventoryOpen = false

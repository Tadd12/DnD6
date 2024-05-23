extends CharacterBase
class_name Player

@export var speed := 200
@onready var interactArea := $InteractArea

var moveable := true

var timeBetweenRounds: int = 10_000
var timeSinceLastRound: int

signal toggleInventory
signal closeUi

# Called when the node enters the scene tree for the first time.
func _ready():
	timeSinceLastRound = Time.get_ticks_msec()


var inFight := false

## Triggers a dialog sequence with a character
func talkTo(Char):
	# Trigger talking Sequence
	pass

## Takes item 
func takeItem(item):
	# TODO: remove item from Map/Chest
	pass

## Reset all Actions the can only be used ones per Short Break 
func takeAShortBreak():
	if not inFight:
		healthPoints = healthPoints + maxHP/2


## Carries out a Spell  [br]
## Coordinates: () the Destination of the Spell [br]
## Spell: (Spell) The Spell to be used
func useSpellOnMap(Coordinates, Spell):
	pass


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("inventory"):
		toggleInventory.emit()
	
	if Input.is_action_just_pressed("ui_cancel"):
		closeUi.emit()
		
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
	if moveable:
		move_and_slide()
	
	if not inFight:
		if Time.get_ticks_msec() - timeSinceLastRound > timeBetweenRounds:
			nextRound()
			timeSinceLastRound = Time.get_ticks_msec()


## Checks if there is an interactable body within the [InteractArea].
## If bodys are found, the [code]playerInteract[/code] method is called on the closest one.
func interact() -> void:
	if interactArea.get_overlapping_bodies():
		var bodies: Array[Node2D] = interactArea.get_overlapping_bodies()
		bodies.sort_custom(
			func(body):	
				return body.get_global_position().distance_to(get_global_position())
		)
		bodies[-1].playerInteract()


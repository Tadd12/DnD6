extends Control

var Characters: Array[CharacterBase] = [
	preload("res://Entities/Maincharacters/Helvina.tres"),
	preload("res://entities/Maincharacters/Brock.tres"),
	preload("res://Entities/Maincharacters/Marjoulaine.tres")
]

var mainScene: Node = preload("res://Scenes/Main/main.tscn").instantiate()

@onready var descriptionDisplay = $MarginContainer/HBoxContainer/VBoxContainer2/DescriptionDisplay
@onready var startButton = $MarginContainer/HBoxContainer/VBoxContainer2/Button

## -1: Random
var currentlySelectedCharacter: CharacterBase

func _onHelvinaSelectPressed():
	currentlySelectedCharacter = Characters[0]
	startButton.disabled = false
	_updateDescription()

func _onBrockSelectPressed():
	currentlySelectedCharacter = Characters[1]
	startButton.disabled = false
	_updateDescription()

func _onMarjoulaineSelectPressed():
	currentlySelectedCharacter = Characters[2]
	startButton.disabled = false
	_updateDescription()
	
func _onRandomSelectPressed():
	currentlySelectedCharacter = null
	startButton.disabled = false
	_updateDescription()

func _onStartGamePressed():
	get_tree().change_scene_to_packed(_selectCharacterInGame())

func _updateDescription():
	descriptionDisplay.clear()
	if currentlySelectedCharacter == null:
		descriptionDisplay.add_text(
			"Selection of a random character.
	As the game starts, one of the characters will be assigned to you, \
determined by the roll of the world's dice. \
Embrace the whims of fate and let destiny decide your path. \
Each character brings unique abilities and stories, \
offering a fresh experience every time you play. \
This element of chance ensures that no two playthroughs are the same, \
adding an extra layer of excitement and unpredictability to your journey. \
Will you become a brave warrior, a cunning rogue, or a wise mage? \
The outcome is beyond your control. \
Trust in the randomness of the universe and prepare for an adventure unlike any other."
		)
	else:
		descriptionDisplay.add_text(currentlySelectedCharacter.decription)

func _selectCharacterInGame() -> PackedScene:
	var packedMain: PackedScene = PackedScene.new()
	# mainScene.get_child()
	packedMain.pack(mainScene)
	return packedMain
	

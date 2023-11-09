class_name CharacterBase
extends Node2D
## This is the BaseClass for all Characters
## like NPC, the Player and MainCharacters


# Character specific static Properties
var characterName: String
var race # : Race

# Character specific semi static Properties
## Saves the main attributes of the Character
var attributes := {'strength': 0, 
				   'dexterity': 0,
				   'intelligence': 0,
				   'wisdom': 0,
				   'constitution': 0,
				   'charisma': 0}

## Saves the main attributes of the Character
var skills := {}  # Skill(str): Bonus(int)  0 = No bonus but available

var inventory := []
var maxHP := 10
## Level(int): Number(int)
var maxSpellPoints := {}  

## A internal class to save the current armor
class ClassArmor:
	func _init():
		var Head = null
		var Cheat = null
		var Legs = null
		var Feet = null
	
	## Computes the ArmorPoints by the currently worn armor
	## If no armor is worn the default is 10
	func getArmorPoints():
		# TODO after creating ArmorBaseClass
		return 10 # Standard if no armor is selected


var armor := ClassArmor.new()

var maxActions := 1
var maxBonusActions := 1

# Character specific Temporary Properties
var currentEffects := []
var inFight := false
var spellPoints := {}

var tempAction := maxActions
var tempBonusAction := maxBonusActions

var _tempHP := 10

# Properties
## Properties for the current HP
var healthPoints: int:
	get:
		return _tempHP
	set(val):
		_tempHP = val
		if _tempHP > maxHP:
			_tempHP = maxHP
		elif _tempHP <= 0:
			onDeath()

## The armor class of the Character
var armorClass: int:
	get:
		return armor.getArmorPoints() + attributes['dexterity']

## init [br]
## 
func _init(name:String, strength:int, dexterity:int, intelligence:int, wisdom:int,
		   constitution:int, charisma:int, pSkills:Dictionary, pRace, hp:int):
	characterName = name
	attributes = {'strength': strength, 
				  'dexterity': dexterity,
				  'intelligence': intelligence,
				  'wisdom': wisdom,
				  'constitution': constitution,
				  'charisma': charisma}
	skills = pSkills
	race = pRace
	maxHP = hp
	healthPoints = hp

## Triggers a dialog sequence with a character
func TalkTo(Char):
	# Trigger talking Sequence
	pass

## Takes item 
func TakeItem(item):
	# TODO: remove item from Map/Chest
	inventory.append(item)


## Reset all Actions the can only be used ones per Short Break 
func TakeAShortBreak():
	if not inFight:
		healthPoints = healthPoints + maxHP/2


# Fight specific functions
## Resets all Round-based temporary variables
func nextRound():
	tempAction = 1
	tempBonusAction = 1


## Attack a Character or a Object on the Map [br]
## CharObj: ([CharacterBase] or MapObject) the Character or a Object on the Map [br]
## Attack: (Attack) The Attack to be used [br]
## Returns: ([int]) If the attack succeded or failed (1: crit. fail, 2: fail, 3: success, 4: crit. success)
func Attack(CharObj, Attack) -> int:
	return 0


## Use a Spell on a Character or a Object on the Map [br]
## CharObj: ([CharacterBase] or MapObject) the Character or a Object on the Map [br]
## Spell: (Spell) The Spell to be used
func UseSpellOnCharacter(CharObj, Spell):
	pass


## Carries out a Spell  [br]
## Coordinates: () the Destination of the Spell [br]
## Spell: (Spell) The Spell to be used
func UseSpellOnMap(Coordinates, Spell):
	pass


## A function to be called if HP reaches 0
func onDeath():
	pass

# Static funcions

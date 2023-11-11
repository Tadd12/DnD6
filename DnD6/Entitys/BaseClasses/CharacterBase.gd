class_name CharacterBase
extends Node2D
## This is the BaseClass for all Characters
## like NPC, the Player and MainCharacters


signal recover_health(hp_event: HealthChangedEvent)
signal overheal(entity: CharacterBase, max_hp: float, new_hp: float)
signal damaged(hp_event: HealthChangedEvent)
signal death(entity: CharacterBase, cause)

# Character specific static Properties
var character_name: String
var race # : Race

# Character specific semi static Properties
## Saves the main attributes of the Character
var attributes := {'strength': 0, 
				   'dexterity': 0,
				   'intelligence': 0,
				   'wisdom': 0,
				   'constitution': 0,
				   'charisma': 0}

var max_hp := 10.0

## Saves the main attributes of the Character
var skills := {}  # Skill(str): Bonus(int)  0 = No bonus but available

var inventory := []
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
	func getArmorPoints() -> int:
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

var hp:= max_hp

func recover_hp(amount: float, cause):
	var new_hp = hp + amount
	if not hp == max_hp:
		recover_health.emit(HealthChangedEvent.new(hp, minf(max_hp, new_hp), amount, self, cause))
	if new_hp > max_hp:
		overheal.emit(self, max_hp, new_hp)	
	hp = minf(max_hp, new_hp)
	
func remove_hp(amount: float, cause):
	minf(1.0, amount)
	var new_hp := maxf(0, hp - amount)
	damaged.emit(HealthChangedEvent.new(hp, new_hp, amount, self, cause))
	if new_hp == 0:
		death.emit(self, cause)
		
	hp = new_hp

## The armor class of the Character
var armorClass: int:
	get:
		return armor.getArmorPoints() + attributes['dexterity']

## init [br]
## 
func _init(pName:String, strength:int, dexterity:int, intelligence:int, wisdom:int,
		   constitution:int, charisma:int, pSkills:Dictionary, pRace, ihp:int):
	self.character_name = pName
	self.attributes = {'strength': strength, 
				  'dexterity': dexterity,
				  'intelligence': intelligence,
				  'wisdom': wisdom,
				  'constitution': constitution,
				  'charisma': charisma}
	self.skills = pSkills
	self.race = pRace
	self.max_hp = ihp
	self.hp = ihp

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
		hp = hp + max_hp/2

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

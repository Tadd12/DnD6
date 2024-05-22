class_name CharacterBase
extends CharacterBody2D
## This is the BaseClass for all Characters
## like NPC, the Player and MainCharacters

# Character specific static Properties
@export var characterName: String
# @export var race # : Race

@export var inventoryData: InventoryData

@export var icon: Texture2D

# Character specific semi static Properties
## Saves the main attributes of the Character
@export_group("Stats")
@export var strength := 0.0
@export var dexterity := 0.0
@export var intelligence := 0.0
@export var charisma := 0.0
@export var wisdom := 0.0
@export var constitution := 0.0
@export_group("")
## Saves the main attributes of the Character
var skills := {}  # Skill(str): Bonus(int)  0 = No bonus but available

@export var maxHP := 10
## Level(int): Number(int)
@export var maxSpellPoints := {}  

## A internal class to save the current armor
class ClassArmor extends RefCounted:
	func _init():
		var armor := {}
		for type in ArmorBase.ARMOR_TYPE:
			armor[type] = null
	
	## Computes the ArmorPoints by the currently worn armor
	## If no armor is worn the default is 10
	func getArmorPoints() -> int:
		# TODO after creating ArmorBaseClass
		return 10 # Standard if no armor is selected

	func setArmor(armor: ArmorBase, type: ArmorBase.ARMOR_TYPE):
		# TODO: Check armorType
		pass
		
	func getArmor() -> Array:
		var arrayArmor := []
		for a in self.armor:
			arrayArmor.append(self.armor[a])
		return arrayArmor

var equippedArmor := ClassArmor.new()

var maxActions := 1
var maxBonusActions := 1

# Character specific Temporary Properties
var currentEffects : Array[EffectBase] = []
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
var armor: int:
	get:
		return equippedArmor.getArmorPoints() + dexterity





# Fight specific functions
## Resets all Round-based temporary variables
func nextRound():
	tempAction = 1
	tempBonusAction = 1
	for effect in currentEffects:
		effect.nextRound(self)
		

## Attack a Character or a Object on the Map [br]
## CharObj: ([CharacterBase] or MapObject) the Character or a Object on the Map [br]
## Attack: (Attack) The Attack to be used [br]
## Returns: ([int]) If the attack succeded or failed (1: crit. fail, 2: fail, 3: success, 4: crit. success)
func attack(CharObj, Attack) -> int:
	return 0


## Use a Spell on a Character or a Object on the Map [br]
## CharObj: ([CharacterBase] or MapObject) the Character or a Object on the Map [br]
## Spell: (Spell) The Spell to be used
func useSpellOnCharacter(CharObj, Spell):
	pass


## A function to be called if HP reaches 0
func onDeath():
	print(name + " died.")


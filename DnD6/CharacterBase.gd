class_name CharacterBase
extends Object

# Character specific static Properties
var name
var race # : Race

# Character specific semi static Properties
var attributes = {'strength': 0, 
				  'dexterity': 0,
				  'intelligence': 0,
				  'wisdom': 0,
				  'constitution': 0,
				  'charisma': 0}

var skills = {}  # Skill(str): Bonus(int)  0 = No bonus but available

var inventory = []
var maxHP = 10
var maxSpellPoints = {}  # Level(int): Number(int)


class ClassArmor:
	func _init():
		var Head = null
		var Cheat = null
		var Legs = null
		var Feet = null
	
	func getArmorPoints():
		# TODO after creating ArmorBaseClass
		return 10 # Standard if no armor is selected


var armor = ClassArmor.new()

var actions = 1
var bonusActions = 1

# Character specific Temporary Properties
var currentEffects = []
var inFight = false
var spellPoints = {}

var tempAction = actions
var tempBonusAction = bonusActions

var tempHP = 10

# Properties
var healthPoints: int:
	get:
		return tempHP
	set(val):
		tempHP = val
		if tempHP > maxHP:
			tempHP = maxHP
		elif tempHP <= 0:
			onDeath()

var armorClass: int:
	get:
		return armor.getArmorPoints() + attributes['dexterity']


func _init(pName, strength, dexterity, intelligence, wisdom, constitution, charisma,
		   pSkills, pRace, hp):
	name = pName
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


func TalkTo(Char):
	# Trigger talking Sequence
	pass

func TakeItem(item):
	'''This a Doc string that explains the Method'''
	inventory.append(item)


func TakeAShortBreak():
	if not inFight:
		healthPoints = healthPoints + maxHP/2


# Fight specific functions
func nextRound():
	actions = 1
	bonusActions = 1


func Attack(CharObj, Attack):
	pass


func UseSpell(CharObj, Spell):
	pass


func onDeath():
	pass

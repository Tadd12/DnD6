class_name CharacterBase
extends Object

# Character specific static Properties
var Name
var Race

# Character specific semi static Properties
var Attributes = {'strength': 0, 
				  'dexterity': 0,
				  'intelligence': 0,
				  'wisdom': 0,
				  'constitution': 0,
				  'charisma': 0}

var Skills = {}  # Skill(str): Bonus(int)  0 = No bonus but available

var Inventory = []
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

var Armor = ClassArmor.new()

var Actions = 1
var BonusActions = 1

# Character specific Temporary Properties
var CurrentEffects = []
var InFight = false
var SpellPoints = {}

var tempAction = Actions
var tempBonusAction = BonusActions

var tempHP = 10

# Properties
var HP: int:
	get:
		return tempHP
	set(val):
		tempHP = val
		if tempHP > maxHP:
			tempHP = maxHP
		elif tempHP <= 0:
			onDeath()

var ArmorClass: int:
	get:
		return Armor.getArmorPoints() + Attributes['dexterity']


func _init(name, strength, dexterity, intelligence, wisdom, constitution, charisma,
		   skills, race, hp):
	Name = name
	Attributes = {'strength': strength, 
				  'dexterity': dexterity,
				  'intelligence': intelligence,
				  'wisdom': wisdom,
				  'constitution': constitution,
				  'charisma': charisma}
	Skills = skills
	Race = race
	maxHP = hp
	HP = hp

func TalkTo(Char):
	# Trigger talking Sequence
	pass

func TakeItem(item):
	Inventory.append(item)

func TakeAShortBreak():
	if not InFight:
		HP = HP + maxHP/2

# Fight specific functions
func nextRound():
	Actions = 1
	BonusActions = 1

func Attack(CharObj, Attack):
	pass
	
func UseSpell(CharObj, Spell):
	pass

func onDeath():
	pass

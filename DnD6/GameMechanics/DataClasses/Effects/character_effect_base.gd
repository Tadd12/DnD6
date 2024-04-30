extends EffectBase
class_name CharacterEffectBase

@export var healEffect: DnDDice = null
@export var damageEffect: DnDDice = null
@export var attributeEffectAttr: String
@export var attributeEffectValue: DnDDice = null
## 1 means no time effect just one call
@export var numberOfRounds: int = 1
var roundsLeft: int

## the function that should be called when the effect
## is given to a Character.
## adds the effect to the list of current effects
## if this is a round based effect
func activate(Character: CharacterBase) -> void:
	self.roundsLeft = numberOfRounds
	nextRound(Character)
	if self.roundsLeft > 0:
		Character.currentEffects.append(self)

## The function the performs a this effect on a character
func performEffectOnCharacter(Character: CharacterBase) -> void:
	if self.roundsLeft <= 0:
		return
	if healEffect != null:
		Character.healthPoints = Character.healthPoints + healEffect.ThrowSum()
	elif damageEffect != null:
		Character.healthPoints = Character.healthPoints - damageEffect.ThrowSum()
	
	print(Character.healthPoints)

## the function that should be called after a round has passed
## returns: the number of how many round are left
func nextRound(Character: CharacterBase) -> int:
	performEffectOnCharacter(Character)
	self.roundsLeft -= 1
	return self.roundsLeft

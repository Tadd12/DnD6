extends EffectBase
class_name CharacterEffectBase

@export var healEffect: Dice = null
@export var damageEffect: Dice = null
@export var effectAttr: String
@export var attributeValue: Dice = null
## 1 means no time effect just one call
@export var numberOfRounds := 1
var roundsLeft: int

## the function that should be called when the effect
## is given to a character.
## adds the effect to the list of current effects
## if this is a round based effect
func activate(character: CharacterBase) -> void:
	roundsLeft = numberOfRounds
	nextRound(character)
	if roundsLeft > 0:
		character.currentEffects.append(self)

## The function the performs a this effect on a character
func performEffectOnCharacter(character: CharacterBase) -> void:
	if roundsLeft <= 0:
		return
	if healEffect != null:
		character.healthPoints += healEffect.throwSum()
	elif damageEffect != null:
		character.healthPoints -= damageEffect.throwSum()
	
	print(character.healthPoints)

## the function that should be called after a round has passed
## returns: the number of how many round are left
func nextRound(character: CharacterBase) -> int:
	performEffectOnCharacter(character)
	roundsLeft -= 1
	return roundsLeft

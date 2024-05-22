extends CharacterBase
class_name PlayableBase



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
class_name DnDDice #TODO: find better Name
extends Resource

@export var numberOfDiceFaces: int = 6
@export var numberOfDice: int = 1
@export var offset: int = 0

## Computes all dices results and 
## returns the their sum
func ThrowSum() -> int:
	var result: int = 0
	for i in range(self.numberOfDice):
		result += _rollOneDice()
	return result

## Computes all dices results and returns the best
func ThrowBest() -> int:
	var result: Array[int] = []
	for i in range(self.numberOfDice):
		result.append(_rollOneDice())
	result.sort()
	return result[0]

## Throws one dice with advantage
## numberOfDice has ot be 1, because advantage
## is not defined for multiple Dices
func ThrowAdvantage() -> int:
	assert (self.numberOfDice == 1)
	return max(_rollOneDice(), _rollOneDice())

## Throws one dice with disadvantage
## numberOfDice has ot be 1, because disadvantage
## is not defined for multiple Dices
func ThrowDisadvantage() -> int:
	assert (self.numberOfDice == 1)
	return min(_rollOneDice(), _rollOneDice())

## simulate a dice roll
func _rollOneDice() -> int:
	return randi() % self.numberOfDiceFaces + offset

class_name Dice
extends Resource

@export var numberOfDiceFaces := 6
@export var numberOfDice := 1
@export var offset := 0

## Computes all dice results and 
## returns their sum + the offset
func throwSum() -> int:
	var result := 0
	for i in range(numberOfDice):
		result += _rollOneDice()
	return result + offset

## Computes all dice results and returns the best
func throwBest() -> int:
	var result: Array[int] = []
	for i in range(numberOfDice):
		result.append(_rollOneDice() + offset)
	result.sort()
	return result[0]

## Throws one dice with advantage
## numberOfDice has to be 1, because advantage
## is not defined for multiple dice
func throwAdvantage() -> int:
	assert (numberOfDice == 1)
	return max(_rollOneDice(), _rollOneDice())

## Throws one dice with disadvantage
## numberOfDice has to be 1, because disadvantage
## is not defined for multiple dice
func throwDisadvantage() -> int:
	assert (numberOfDice == 1)
	return min(_rollOneDice(), _rollOneDice())

## simulate a dice roll
func _rollOneDice() -> int:
	return randi_range(1, numberOfDiceFaces)

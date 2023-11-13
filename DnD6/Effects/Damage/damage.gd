extends Node2D



func execute(targets, amount, cause):
	for target in targets:
		target.damage(amount, cause)

extends Node

var contens := {}
@export var size := 20

func add_item(item: ItemBase):
	if contens.has(item):
			contens.[item] += 1
	

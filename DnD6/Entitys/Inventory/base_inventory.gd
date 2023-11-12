extends Node
class_name BaseInventory

var contens := {}
@export var size := 20

func add_item(item: ItemBase):
	if contens.has(item):
			contens[item] += 1
	
func add_itemlist(item_list: Array[ItemBase]):
	for item in item_list:
		add_item(item)

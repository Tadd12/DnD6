extends Node
class_name InventoryBase


@onready var parent := get_parent()
#desc holds the items as the key and the itemcount as the value
var contens := {}
var items: Array:
	get:
		return contens.keys()

var total_weight:= 0

var max_weight: float:
	get:
		return parent.

#desc Increses the itemcount of the item by one and returns its index. 
# If the item can't be placed in the inventory the return value is -1
func add_single_item(item: ItemBase) -> int:
	if contens.has(item):
			contens[item] += 1
	elif :
		contens[item] = 1
	return items.rfind(item)
	
func add_items(item_dict: Dictionary):
	var idx: int
	var overflow_items := []
	for item in item_dict.keys():
		if item in contens:
			contens[item] += item_dict[item]
		elif contens.size() < size:
			contens[item] = item_dict[item]
		else:
			overflow_items.append(item)
		
		
#desc Returns the index of the item. If the item is not present it reutrns -1
func get_item_index(item: ItemBase) -> int:
	return items.find(item)

	
#desc Returns the count of the item. If the item is not present it returns 0
func get_itemcount(item: ItemBase) -> int:
	return contens.get(item, 0)

#desc Decreses the itemcount by 1 and returns the item
func remove_single_item(idx: int) -> ItemBase:
	var item = items[idx]
	contens[item] -= 1
	if contens[item] == 0:
		contens.erase(item)
	return item

#desc Decreses the itemcount of the item at the index by [code]count[/code] and returns the item. If the count is bigger than the itemcount in the inventory, the function will return null instead
func remove_item_amount(idx: int, count: int) -> ItemBase:
	var item = items[idx]
	if contens[item] > count:
		return null
	contens[item] -= count
	if contens[item] == 0:
		contens.erase(item)
	return item
	
	
#desc Removes the item at the index and returns it in a Dictionary. The key "item" holds the item and "count" the itemcount
func remove_item_stack(idx: int) -> Dictionary:
	var item = items[idx]
	var count = contens[item]
	contens.erase(item)
	return {"item": item, "count": count}

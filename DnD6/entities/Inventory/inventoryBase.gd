extends Node
class_name InventoryBase


@onready var parent := get_parent()
#desc holds the items as the key and the itemcount as the value
var contens := {}
var items: Array:
	get:
		return contens.keys()

var totalWeight:= 0

var maxWeight: float:
	get:
		return parent.maxWeight

#desc Increses the itemcount of the item by one and returns its index. 
# If the item can't be placed in the inventory the return value is -1
func addItem(item: ItemBase) -> int:
	if totalWeight + item.weight > maxWeight:
		return -1
	if contens.has(item):
		contens[item] += 1
	else:
		contens[item] = 1
	return items.rfind(item)
	
		
#desc Returns the index of the item. If the item is not present it reutrns -1
func getItemIndex(item: ItemBase) -> int:
	return items.find(item)

	
#desc Returns the count of the item. If the item is not present it returns 0
func getItemcount(item: ItemBase) -> int:
	return contens.get(item, 0)

#desc Decreses the itemcount by 1 and returns the item
func removeSingleItem(idx: int) -> ItemBase:
	var item = items[idx]
	contens[item] -= 1
	if contens[item] == 0:
		contens.erase(item)
	return item

#desc Decreses the itemcount of the item at the index by [code]count[/code] and returns the item. If the count is bigger than the itemcount in the inventory, the function will return null instead
func removeItemAmount(idx: int, count: int) -> ItemBase:
	var item = items[idx]
	if contens[item] > count:
		return null
	contens[item] -= count
	if contens[item] == 0:
		contens.erase(item)
	return item
	
	
#desc Removes the item at the index and returns it in a Dictionary. The key "item" holds the item and "count" the itemcount
func removeItemStack(idx: int) -> Dictionary:
	var item = items[idx]
	var count = contens[item]
	contens.erase(item)
	return {"item": item, "count": count}

extends Resource
class_name InventoryData

signal inventoryUpdated(inventoryData: InventoryData)
signal inventoryInteract(inventoryData: InventoryData, index: int, button: int, doubleClicked: bool)

@export var slotDatas: Array[SlotData]

## Returns the contens of the slot at the [param index] and removes the contents from the slot.
func grabSlotData(index: int) -> SlotData:
	var slotData := slotDatas[index]
	
	if slotData:
		slotDatas[index] = null
		inventoryUpdated.emit(self)
		return slotData
	else:
		return null

## Returns a new [SlotData] with the same contens but half the amount (rounded up)
## The amount of the data at the [param index] gets updated by the removed amount.
## If the remaining amount is less then [code]1[/code] the data is set to [code]null[/code]
## If there is not data at the [param index] the function returns [code]null[/code]
func grabHalfSlotData(index: int) -> SlotData:
	var slotData := slotDatas[index]
	
	if slotData:
		var data := slotData.getMultipleSlotData((slotData.quantity + 1) / 2)
		if slotData.quantity < 1:
			slotDatas[index] = null
		inventoryUpdated.emit(self)
		return data
	else:
		return null


## Tries to merge [param grabbedSlotData] and the [SlotData] at the [param index].
## If the data can't be merged, the data at [param index] gets set to the [param grabbedSlotData] 
## Then the old data at [param index] will be returned by this function.
func dropSlotData(grabbedSlotData : SlotData, index: int) -> SlotData:
	var slotData := slotDatas[index]
	
	var returnSlotData: SlotData
	if slotData and slotData.canMergeWith(grabbedSlotData):
		slotData.mergeWith(grabbedSlotData)
	else:
		slotDatas[index] = grabbedSlotData
		returnSlotData = slotData
		
	inventoryUpdated.emit(self)
	return returnSlotData
	
	
## If the SlotData at [param index] is [code]null[/code], it is set to a copy of [param grabbedSlotData] with the amount [code]1[/code].
## If the SlotData is not [code]null[/code], it will attempt to merge a new copy of [param grabbedSlotData] with the data.
## If one of the above was successful, the amount of [param grabbedSlotData] will be lowered by [code]1[/code].
## The modified value of [param grabbedSlotData] will be returned if the amount is over 0, else the return value is [code]null[/code]
func dropSingleSlotData(grabbedSlotData : SlotData, index: int) -> SlotData:
	var slotData := slotDatas[index]
	
	if not slotData:
		slotDatas[index] = grabbedSlotData.getSingleSlotData()
	elif slotData.canMergeWith(grabbedSlotData):
		slotData.mergeWith(grabbedSlotData.getSingleSlotData())
	
	
	inventoryUpdated.emit(self)
	
	if grabbedSlotData.quantity > 0:
		return grabbedSlotData
	else:
		return null

		
## Merges all [SlotData] in the open inventory with the [param grabbedSlotData].
## It returns the [SlotData] with the added quantity
func mergeAllSlotData(grabbedSlotData: SlotData) -> SlotData:
	for i in range(slotDatas.size()):
		var slotData := slotDatas[i]
		if not slotData:
			continue
		if grabbedSlotData.canMergeWith(slotData):
			grabbedSlotData.mergeWith(slotData)
			slotDatas[i] = null
			
	inventoryUpdated.emit(self)
	
	return grabbedSlotData


## Emits the inventoryInteract signal with the function arguments and a refrence to self as the [InventoryData]
func _onSlotClicked(index: int, button: int, doubleClicked: bool) -> void:
	inventoryInteract.emit(self, index, button, doubleClicked)

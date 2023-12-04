extends Resource
class_name InventoryData

signal inventoryUpdated(inventoryData: InventoryData)
signal inventoryInteract(inventoryData: InventoryData, index: int, button: int, double: bool)

@export var slotDatas: Array[SlotData]

#desc Returns the contens of the slot at the [param index] and removes the contents from the slot.
func grabSlotData(index: int) -> SlotData:
	var slotData := slotDatas[index]
	
	if slotData:
		slotDatas[index] = null
		inventoryUpdated.emit(self)
		return slotData
	else:
		return null

#desc Returns a new [SlotData] with the same contens but half the amount (rounded up)
#desc The amount of the data at the [param index] gets updated by the removed amount.
#desc If the remaining amount is less then [code]1[/code] the data is set to [code]null[/code]
#desc If there is not data at the [param index] the function returns [code]null[/code]
func grabHalfSlotData(index: int) -> SlotData:
	var slotData := slotDatas[index]
	
	if slotData:
		var data = slotData.getMultipleSlotData((slotData.quantity + 1) / 2)
		if slotData.quantity < 1:
			slotDatas[index] = null
		inventoryUpdated.emit(self)
		return data
	else:
		return null


#desc Tries to merge [param grabbedSlotData] and the [SlotData] at the [param index].
#desc If the data can't be merged, the data at [param index] gets set to the [param grabbedSlotData] 
#desc Then the old data at [param index] will be returned by this function.
func dropSlotData(grabbedSlotData : SlotData, index: int) -> SlotData:
	var slotData := slotDatas[index]
	
	var return_slotData: SlotData
	if slotData and slotData.canMergeWith(grabbedSlotData):
		slotData.mergeWith(grabbedSlotData)
	else:
		slotDatas[index] = grabbedSlotData
		return_slotData = slotData
		
	inventoryUpdated.emit(self)
	return return_slotData
	
	
#desc If the SlotData at [param index] is [code]null[/code], it is set to a copy of [param grabbedSlotData] with the amount [code]1[/code].
#desc If the SlotData is not [code]null[/code], it will attempt to merge a new copy of [param grabbedSlotData] with the data.
#desc If one of the above was successful, the amount of [param grabbedSlotData] will be lowered by [code]1[/code].
#desc The modified value of [param grabbedSlotData] will be returned if the amount is over 0, else the return value is [code]null[/code]
func drop_single_slotData(grabbedSlotData : SlotData, index: int) -> SlotData:
	var slotData := slotDatas[index]
	
	if not slotData:
		slotDatas[index] = grabbedSlotData.get_single_slotData()
	elif slotData.canMergeWith(grabbedSlotData):
		slotData.mergeWith(grabbedSlotData.get_single_slotData())
	
	
	inventoryUpdated.emit(self)
	
	if grabbedSlotData.quantity > 0:
		return grabbedSlotData
	else:
		return null

		

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


#desc Emits the inventoryInteract signal with the functio arguments and a refrence to self as the [InventoryData]
func on_slotClicked(index: int, button: int, double: bool) -> void:
	inventoryInteract.emit(self, index, button, double)

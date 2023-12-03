extends Resource
class_name InventoryData

signal inventory_updated(inventory_data: InventoryData)
signal inventory_interact(inventory_data: InventoryData, index: int, button: int, double: bool)

@export var slot_datas: Array[SlotData]

#desc Returns the contens of the slot at the [param index] and removes the contents from the slot.
func grab_slot_data(index: int) -> SlotData:
	var slot_data := slot_datas[index]
	
	if slot_data:
		slot_datas[index] = null
		inventory_updated.emit(self)
		return slot_data
	else:
		return null

#desc Returns a new [SlotData] with the same contens but half the amount (rounded up)
#desc The amount of the data at the [param index] gets updated by the removed amount.
#desc If the remaining amount is less then [code]1[/code] the data is set to [code]null[/code]
#desc If there is not data at the [param index] the function returns [code]null[/code]
func grab_half_slot_data(index: int) -> SlotData:
	var slot_data := slot_datas[index]
	
	if slot_data:
		var data = slot_data.get_multiple_slot_data((slot_data.quantity + 1) / 2)
		if slot_data.quantity < 1:
			slot_datas[index] = null
		inventory_updated.emit(self)
		return data
	else:
		return null


#desc Tries to merge [param grabbed_slot_data] and the [SlotData] at the [param index].
#desc If the data can't be merged, the data at [param index] gets set to the [param grabbed_slot_data] 
#desc Then the old data at [param index] will be returned by this function.
func drop_slot_data(grabbed_slot_data : SlotData, index: int) -> SlotData:
	var slot_data := slot_datas[index]
	
	var return_slot_data: SlotData
	if slot_data and slot_data.can_merge_with(grabbed_slot_data):
		slot_data.merge_with(grabbed_slot_data)
	else:
		slot_datas[index] = grabbed_slot_data
		return_slot_data = slot_data
		
	inventory_updated.emit(self)
	return return_slot_data
	
	
#desc If the SlotData at [param index] is [code]null[/code], it is set to a copy of [param grabbed_slot_data] with the amount [code]1[/code].
#desc If the SlotData is not [code]null[/code], it will attempt to merge a new copy of [param grabbed_slot_data] with the data.
#desc If one of the above was successful, the amount of [param grabbed_slot_data] will be lowered by [code]1[/code].
#desc The modified value of [param grabbed_slot_data] will be returned if the amount is over 0, else the return value is [code]null[/code]
func drop_single_slot_data(grabbed_slot_data : SlotData, index: int) -> SlotData:
	var slot_data := slot_datas[index]
	
	if not slot_data:
		slot_datas[index] = grabbed_slot_data.get_single_slot_data()
	elif slot_data.can_merge_with(grabbed_slot_data):
		slot_data.merge_with(grabbed_slot_data.get_single_slot_data())
	
	
	inventory_updated.emit(self)
	
	if grabbed_slot_data.quantity > 0:
		return grabbed_slot_data
	else:
		return null

		

func merge_all_slot_data(grabbed_slot_data: SlotData) -> SlotData:
	for i in range(slot_datas.size()):
		var slot_data := slot_datas[i]
		if not slot_data:
			continue
		if grabbed_slot_data.can_merge_with(slot_data):
			grabbed_slot_data.merge_with(slot_data)
			slot_datas[i] = null
			
	inventory_updated.emit(self)
	
	return grabbed_slot_data


#desc Emits the inventory_interact signal with the functio arguments and a refrence to self as the [InventoryData]
func on_slot_clicked(index: int, button: int, double: bool) -> void:
	inventory_interact.emit(self, index, button, double)

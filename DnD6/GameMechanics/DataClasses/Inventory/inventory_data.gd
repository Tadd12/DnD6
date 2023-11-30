extends Resource
class_name InventoryData

signal inventory_updated(inventory_data: InventoryData)
signal inventory_interact(inventory_data: InventoryData, index: int, button: int, double: bool)

@export var slot_datas: Array[SlotData]


func grab_slot_data(index: int) -> SlotData:
	var slot_data = slot_datas[index]
	
	if slot_data:
		slot_datas[index] = null
		inventory_updated.emit(self)
		return slot_data
	else:
		return null

func grab_half_slot_data(index: int) -> SlotData:
	var slot_data = slot_datas[index]
	
	if slot_data:
		var data = slot_data.get_multiple_slot_data((slot_data.quantity + 1) / 2)
		if not slot_data.quantity > 0:
			slot_datas[index] = null
		inventory_updated.emit(self)
		return data
	else:
		return null

func drop_slot_data(grabbed_slot_data : SlotData, index: int) -> SlotData:
	var slot_data = slot_datas[index]
	
	var return_slot_data: SlotData
	if slot_data and slot_data.can_merge_with(grabbed_slot_data):
		slot_data.merge_with(grabbed_slot_data)
	else:
		slot_datas[index] = grabbed_slot_data
		return_slot_data = slot_data
		
	inventory_updated.emit(self)
	return return_slot_data
	
func drop_single_slot_data(grabbed_slot_data : SlotData, index: int) -> SlotData:
	var slot_data = slot_datas[index]
	
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
		var slot_data = slot_datas[i]
		if not slot_data:
			continue
		if grabbed_slot_data.can_merge_with(slot_data):
			grabbed_slot_data.merge_with(slot_data)
			slot_datas[i] = null
			
	inventory_updated.emit(self)
	
	return grabbed_slot_data

func on_slot_clicked(index: int, button: int, double: bool) -> void:
	inventory_interact.emit(self, index, button, double)

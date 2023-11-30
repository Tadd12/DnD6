extends Resource
class_name SlotData


@export var item_data: ItemData
@export var quantity: int = 1: set = set_quantity

func can_merge_with(other_slot_data: SlotData) -> bool:
	return item_data == other_slot_data.item_data \
			and item_data.stackable

func merge_with(other_slot_data: SlotData) -> void:
	quantity += other_slot_data.quantity

func get_single_slot_data() -> SlotData:
	var new_slot_data = duplicate()
	new_slot_data.quantity = 1
	quantity -= 1
	return new_slot_data

func get_multiple_slot_data(amount: int) -> SlotData:
	var new_slot_data = duplicate()
	new_slot_data.quantity = amount
	quantity -= amount
	return new_slot_data

func set_quantity(value: int) -> void:
	quantity = value
	if quantity > 1 and not item_data.stackable:
		quantity = 1
		push_error("{0} is not stackable. Setting quantity to 1".format([item_data.name]))
	

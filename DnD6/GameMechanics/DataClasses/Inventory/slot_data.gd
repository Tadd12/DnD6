extends Resource
class_name SlotData


@export var item_data: ItemData
@export var quantity: int = 1: set = set_quantity

#desc Returns if the [SlotData] can be merged with the [param other_slot_data].
func can_merge_with(other_slot_data: SlotData) -> bool:
	return item_data == other_slot_data.item_data \
			and item_data.stackable

			
#desc Adds the quantity of [param other_slot_data] to itself
func merge_with(other_slot_data: SlotData) -> void:
	quantity += other_slot_data.quantity

	
#desc Returns a copy of this [SlotData] instace with the quantity set to [code]1[/code].
#desc The quantity of this [SelotData] gets reduced by [code]1[/code]
func get_single_slot_data() -> SlotData:
	var new_slot_data := duplicate()
	new_slot_data.quantity = 1
	quantity -= 1
	return new_slot_data


#desc Returns a copy of this [SlotData] instace with the quantity set to [param amount].
#desc The quantity of this [SelotData] gets reduced by [param amount]
func get_multiple_slot_data(amount: int) -> SlotData:
	var new_slot_data := duplicate()
	new_slot_data.quantity = amount
	quantity -= amount
	return new_slot_data

	
#desc Sets the quantity to [param value].
#desc Throws an Error if the quantity is less than [code]1[/code] or the item is not stackable.
func set_quantity(value: int) -> void:
	quantity = value
	if quantity > 1 and not item_data.stackable:
		quantity = 1
		push_error("{0} is not stackable. Setting quantity to 1".format([item_data.name]))
	

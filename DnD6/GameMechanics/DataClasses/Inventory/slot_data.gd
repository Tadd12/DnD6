extends Resource
class_name SlotData


@export var itemData: ItemData
@export var quantity: int = 1: set = set_quantity

#desc Returns if the [SlotData] can be merged with the [param other_slotData].
func canMergeWith(other_slotData: SlotData) -> bool:
	return itemData == other_slotData.itemData \
			and itemData.stackable

			
#desc Adds the quantity of [param other_slotData] to itself
func mergeWith(other_slotData: SlotData) -> void:
	quantity += other_slotData.quantity

	
#desc Returns a copy of this [SlotData] instace with the quantity set to [code]1[/code].
#desc The quantity of this [SelotData] gets reduced by [code]1[/code]
func getSingleSlotData() -> SlotData:
	var newSlotData := duplicate()
	newSlotData.quantity = 1
	quantity -= 1
	return newSlotData


#desc Returns a copy of this [SlotData] instace with the quantity set to [param amount].
#desc The quantity of this [SelotData] gets reduced by [param amount]
func getMultipleSlotData(amount: int) -> SlotData:
	var newSlotData := duplicate()
	newSlotData.quantity = amount
	quantity -= amount
	return newSlotData

	
#desc Sets the quantity to [param value].
#desc Throws an Error if the quantity is less than [code]1[/code] or the item is not stackable.
func set_quantity(value: int) -> void:
	quantity = value
	if quantity > 1 and not itemData.stackable:
		quantity = 1
		push_error("{0} is not stackable. Setting quantity to 1".format([itemData.name]))
	

extends Resource
class_name SlotData


@export var itemData: ItemData
@export var quantity: int = 1: set = setQuantity

#desc Returns if the [SlotData] can be merged with the [param otherSlotData].
func canMergeWith(otherSlotData: SlotData) -> bool:
	return itemData == otherSlotData.itemData \
			and itemData.stackable

			
#desc Adds the quantity of [param otherSlotData] to itself
func mergeWith(otherSlotData: SlotData) -> void:
	quantity += otherSlotData.quantity

	
#desc Returns a copy of this [SlotData] instace with the quantity set to [code]1[/code].
#desc The quantity of this [SlotData] gets reduced by [code]1[/code]
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
func setQuantity(value: int) -> void:
	quantity = value
	if quantity > 1 and not itemData.stackable:
		quantity = 1
		push_error("{0} is not stackable. Setting quantity to 1".format([itemData.name]))
	

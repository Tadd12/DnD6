extends Resource
class_name ItemBase

# Proprties
## Name of the Item
@export var name: String
@export var description: String
## The Weight of the Item
@export var weight: float
## Whether the Item is Stackable in the Inventory
@export var stackable: bool
## The icon to be shown in the inventory 
@export var inventoryIcon: Texture
## All passiv effects 
@export var passivEffects: Array[EffectBase]
@export var activeEffects: Array[EffectBase]

func UseOnCharacter(character: CharacterBase) -> void:
	for effect in activeEffects:
		if is_instance_of(effect, CharacterEffectBase):
			effect.activate(character)
	return

func UseOnItem(item: ItemBase) -> void:
	for effect in activeEffects:
		if is_instance_of(effect, CharacterEffectBase):
			item.activeEffects.append(effect)
		else:
			effect.activate(item)
	return

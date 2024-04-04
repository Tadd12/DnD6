extends Resource
class_name ItemData

enum ITEM_TYPE {HEAD, CHEST, LEGS, FEET, MAIN_HAND, OFF_HAND, RING, CONSUMEABLE, PLAIN}

@export var name: String = ""
@export_multiline var description: String = ""
@export var stackable: bool = false
@export var texture: Texture
@export var type : Array[ITEM_TYPE]


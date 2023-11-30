extends Resource
class_name ItemData

@export var name: String = ""
@export_multiline var description: String = ""
@export var stackable: bool = false
@export var texture: Texture
@export var consume_script: Script = null
@export var equip_script: Script = null


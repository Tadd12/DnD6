class_name ArmorBase
extends ItemBase

enum ARMOR_PART {
	HEAD,
	CHEST,
	LEGS,
	ARMS,
	FEET,
}

enum ARMOR_TYPE {
	CLOTH,
 	LIGHT_ARMOR,
	MIDDLE_ARMOR,
	HEAVY_ARMOR,
	SHIELD,
}

@export var armorType: ARMOR_TYPE
@export var armorPart: ARMOR_PART
@export var armorBonus: int

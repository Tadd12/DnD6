class_name ArmorBase
extends ItemBase

enum ArmorType {
	HEAD,
	CHEST,
	LEGS,
	ARMS,
	FEET	
}

func _init(ArmorName:String, pWeight, type:ArmorType, bonus:int, effects=null, icon=null):
	super(ArmorName, pWeight, effects, icon)
	self.armorType = type
	self.armorBonus = bonus

extends ItemBase
class_name WeaponBase

enum WEAPON_CLASS {
	SWORD,
	BOW,
	JAVELIN,
	MAGICAL,
	AXE,
	HAMMER
}

@export var attackBonus: int
@export var standardDamageDice: DnDDice
@export var weaponRange: int
@export var weaponClass: WEAPON_CLASS
@export var twoHanded: bool

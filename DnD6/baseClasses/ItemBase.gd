class_name ItemBase
extends Resource

# Proprties
## Name of the Item
var itemName: String
## The Weight of the Item
var weight: float
## The icon to be shown in the inventory 
var inventoryIcon: ImageTexture = ImageTexture.create_from_image(Image.load_from_file("res://Sprites/ItemSprites/MissingIcon.png"))
##
var listOfEffects: Array

## 
## pName (String): Name of the Items [br]
## pWeight (Float): Weight of the Item [br]
## effects (list of effects): [br]
## icon (ImageTexture or String): The Icon or 
## the File of the icon (Icon must be in sprites/ItemSprites/ )
func _init(pName, pWeight, effects=null, icon=null):
	self.itemName = pName
	self.weight = pWeight
	if effects != null:
		self.listOfEffects = effects
	if icon != null:
		if icon is ImageTexture:
			self.inventoryIcon = icon
		elif icon is String:
			self.inventoryIcon = ImageTexture.create_from_image(
				Image.load_from_file("res://sprites/ItemSprites/%s" % icon))

## returns The Metadata of the item
func getMetadata() -> Dictionary:
	return {'Name': itemName,
			'Weight': weight}

func _openWorldUsage(user: CharacterBase) -> bool:
	return false

func _encounterUsage(user: CharacterBase) -> bool:
	return false

static func _loadFromDB(id=null, sid=null):
	if id != null:
		var a = MiscFunctions.loadDataFromDB(['ItemID', 'Weight', 'Icon', 'NameEnglish Name'],
			'ItemView', 'ItemID == %d' % id)[0]
		return new(a['Name'], a['Weight'], null, a['Icon'])
	elif sid != null:
		pass
	else:
		assert(false, "only id or sid must be set")

# static

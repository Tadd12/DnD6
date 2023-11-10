extends ItemBase


func _init():
    name = "Apple"
    weight = 0.1
    inventoryIcon = load("res://Sprites/ItemSprites/Apple.png")
    
func open_world_usage(user: CharacterBase) -> bool:
    user.healthpoints += 1
    return true
    
func encounter_usage(user: CharacterBase) -> bool:
    return open_world_usage(user)


class_name HealthPotion
extends ItemBase

# TODO write cause
func _world_usage( user, ):
	effects.heal.execute([user], 3, null)

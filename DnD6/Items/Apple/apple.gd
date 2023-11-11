class_name Apple
extends ItemBase

# TODO write cause
func _world_usage( user, ):
	effects.heal.execute([user], 1, null)

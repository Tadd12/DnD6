extends ItemBase

# TODO write cause
func _world_usage( user, ):
	effects.heal.execute([user], 1, null)

func _encounter_usage(user):
	pass

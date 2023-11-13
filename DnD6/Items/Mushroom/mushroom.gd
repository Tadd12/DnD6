extends ItemBase


@export var test: Script

# Add behaviour for use outside of encounters
func _world_usage(user):
	test.execute([user], 1, null)
	pass
	

# Add behaviour for use in an encounter
func _encounter_usage(user):
	pass


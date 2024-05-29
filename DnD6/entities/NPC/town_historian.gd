extends NpcBase

func _onDialogSignal(value) -> void:
	print("Signal recieved with values: {0}".format([value]))

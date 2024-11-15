extends Node

@onready var child = self.get_child(0)

func unlockReward():
	print("SETTING ENABLED")
	child.setEnabled()
	pass
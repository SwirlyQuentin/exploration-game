extends Node2D
@onready var level1 = $Level1
@onready var level2 = $Level2

func setJump():
	level1.visible = false
	level2.visible = true


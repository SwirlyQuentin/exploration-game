extends Control

func _ready():
    visible = false

func setPosition(newPosition):
    self.global_position = newPosition

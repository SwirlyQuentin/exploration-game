extends Node2D
@onready var sprite:Sprite2D = $SwitchSprite

var enabled = false

var close = false


func _input(event):
	if (event.is_action_pressed("interact") && close):
		if (enabled):
			disable()
		else:
			enable()


func enable():
	enabled = true
	sprite.modulate = Color("6dde00")
	Signals.emit_signal("checkSwitch")
	pass


func disable():
	enabled = false
	sprite.modulate = Color("ffffff")
	pass



func _on_area_2d_area_exited(area:Area2D) -> void:
	if (area.is_in_group("player")):
			close = false
			pass

func _on_area_2d_area_entered(area:Area2D) -> void:
	if (area.is_in_group("player")):
		close = true
		pass

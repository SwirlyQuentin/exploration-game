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




func _on_area_2d_body_entered(body:Node2D) -> void:
	if (body.is_in_group("player")):
		close = true
		pass


func _on_area_2d_body_exited(body:Node2D) -> void:
	if (body.is_in_group("player")):
		close = false
		pass

func enable():
	enabled = true
	sprite.modulate = Color("6dde00")
	Signals.emit_signal("checkSwitch")
	pass


func disable():
	enabled = false
	sprite.modulate = Color("ffffff")
	pass

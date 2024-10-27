extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_collect_check_body_entered(body:Node2D) -> void:
	if (body.is_in_group("player")):
		Signals.emit_signal("addCollectable", self)

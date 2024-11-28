extends Node2D

@export var zone:String




func _on_area_2d_area_entered(area:Area2D) -> void:
	Signals.emit_signal("blackFade", zone)

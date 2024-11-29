extends Node2D

@export var zone:String
@export var worldSpace:bool
@onready var exitPoint = $ExitSpace




func _on_area_2d_area_entered(area:Area2D) -> void:
	if (worldSpace):
		PlayerManager.exitSpace = exitPoint.global_position
	Signals.emit_signal("blackFade", zone)

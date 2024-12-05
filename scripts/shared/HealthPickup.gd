extends Node2D

@export var healAmount:int = 20

func _on_area_2d_area_entered(area:Area2D) -> void:
    if (area.is_in_group("player")):
        collect()

func collect():
    Signals.emit_signal("addHealth", healAmount)
    queue_free()

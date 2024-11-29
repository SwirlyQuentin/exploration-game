extends Node2D

var close = false

func _on_area_2d_area_entered(area:Area2D) -> void:
    close = true




func _input(event):
    if (event.is_action_pressed("interact") && close):
        Signals.emit_signal("completeQuest")
        Signals.emit_signal("queueComplete")
        pass

func _on_area_2d_area_exited(area:Area2D) -> void:
    close = false

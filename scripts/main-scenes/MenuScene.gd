extends Node


func _on_texture_button_button_up() -> void:
    Signals.emit_signal("changeState", "tutState")

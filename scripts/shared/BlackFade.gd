extends ColorRect

@onready var fadeAnim:AnimationPlayer = $Fade

var finished = false

func fade():
    fadeAnim.play("fade")

        

func _on_fade_animation_finished(anim_name:StringName) -> void:
    finished = true

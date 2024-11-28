extends ColorRect

@onready var fadeAnim:AnimationPlayer = $Fade

var finished = false
var zone = ""

func _ready():
    Signals.connect("blackFade", fade)

func fade(zone):
    fadeAnim.play("fade")
    Signals.emit_signal("disablePlayer")
    self.zone = zone

        

func _on_fade_animation_finished(anim_name:StringName) -> void:
    finished = true
    if (zone != ""):
        Signals.emit_signal("changeState", zone)

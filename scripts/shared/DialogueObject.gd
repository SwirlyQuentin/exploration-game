extends Node2D

@export var cutscene:String
@export var obj:String = ""

var close = false

func _ready():
    pass

func _input(event):
    if (event.is_action_pressed("interact") && close):
        Signals.emit_signal("startCutscene", cutscene)
        if (obj != ""):
            Signals.emit_signal("completeObj", obj, true)


func _on_close_check_area_entered(area:Area2D) -> void:
    if (area.is_in_group("player")):
        close = true

func _on_close_check_area_exited(area:Area2D) -> void:
    if (area.is_in_group("player")):
        close = false

extends Node

@onready var blackFade = $BlackFade


func _ready():
    print("emitted")
    Signals.emit_signal("tutorial")
    Signals.emit_signal("startCutscene", "openingCutscene_part1")

func _on_exit_trigger_area_entered(area:Area2D) -> void:
    area.get_parent().disable()
    blackFade.fade("")

func _physics_process(delta):
    if (blackFade.finished):
        Signals.emit_signal("tutorialFinished")
        Signals.emit_signal("changeState", "gameState")
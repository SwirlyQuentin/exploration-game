extends Node2D

@onready var ind = $InteractIndicator

func _input(event):
    if (event.is_action_pressed("interact") && ind.inRange):
        ind.inRange = false
        ind.disable()
        ind.hideIcon()
        Signals.emit_signal("enableDialogueObject", "Cabinet")
        Signals.emit_signal("enableDialogueObject", "Bed")
        Signals.emit_signal("startCutscene", "openingCutscene_part2")


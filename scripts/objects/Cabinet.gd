extends Node2D

@onready var ind = $InteractIndicator

func _ready():
    Signals.connect("enableDialogueObject", checkObject)
    ind.inRange = false
    ind.disable()
    ind.hideIcon()

func _input(event):
    if (event.is_action_pressed("interact") && ind.inRange):
        ind.inRange = false
        ind.disable()
        ind.hideIcon()
        Signals.emit_signal("enableDialogueObject", "Note")
        Signals.emit_signal("startCutscene", "openingCutscene_part3")


func checkObject(object):
    if (object == "Cabinet"):
        ind.enable()

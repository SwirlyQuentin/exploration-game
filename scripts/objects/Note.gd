extends Node2D

@onready var ind = $InteractIndicator
@onready var noteTexture = $NoteTexture

var showing = false

func _ready():
    Signals.connect("enableDialogueObject", checkObject)
    ind.inRange = false
    ind.disable()
    ind.hideIcon()
    noteTexture.visible = false

func _input(event):
    if (event.is_action_pressed("interact") && ind.inRange):
        if (showing):
            noteTexture.visible = false
            showing = false
            Signals.emit_signal("enablePlayer")
            Signals.emit_signal("enableDialogueObject", "Crack")
            Signals.emit_signal("startCutscene", "openingCutscene_part5")
        else:
            noteTexture.visible = true
            showing = true
            Signals.emit_signal("disablePlayer")


func checkObject(object):
    if (object == "Note"):
        ind.enable()
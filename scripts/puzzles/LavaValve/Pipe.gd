extends Node2D

@export_enum("0:0", "90:90", "180:180", "270:270") var correctRotation:int = 0

var rotations = [deg_to_rad(0), deg_to_rad(90), deg_to_rad(180), deg_to_rad(270)]
var currentRotation = 0
var arrayIndex = 0
var close = false


func _input(event):
    if (event.is_action_pressed("interact") && close):
        rotatePipe()

func _ready():
    var newRotation = rotations.pick_random()
    self.rotation = newRotation
    currentRotation = rad_to_deg(newRotation)
    arrayIndex = rotations.find(newRotation)

func rotatePipe():
    if (arrayIndex == rotations.size() - 1):
        arrayIndex = 0
    else:
        arrayIndex += 1
    self.rotation = rotations[arrayIndex]
    currentRotation = rad_to_deg(rotations[arrayIndex])
    Signals.emit_signal("checkPipes")
    pass

func _on_close_check_area_entered(area:Area2D) -> void:
    if (area.is_in_group("player")):
        close = true


func _on_close_check_area_exited(area:Area2D) -> void:
    if (area.is_in_group("player")):
        close = false

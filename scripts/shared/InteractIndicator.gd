extends Area2D

@onready var icon = $Icon

var inRange = false
var disabled = false

func _ready():
    hideIcon()

func showIcon():
    icon.visible = true
    pass

func hideIcon():
    icon.visible = false
    pass
    
func _on_area_entered(area:Area2D) -> void:
    if (!disabled):
        showIcon()
        inRange = true


func _on_area_exited(area:Area2D) -> void:
    hideIcon()
    inRange = false

func disable():
    disabled = true
func enable():
    disabled = false


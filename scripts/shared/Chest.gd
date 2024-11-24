extends Node2D

@onready var reward = $Reward
@onready var openedSprite = $Opened
@onready var unopenedSprite = $Unopened
@onready var interactiveNodes = $InteractiveNodes

var close = false


func _input(event):
    if (event.is_action_pressed("interact") && close):
        open()

        
func open():
    reward.unlockReward()
    openedSprite.visible = true
    unopenedSprite.visible = false
    close = false
    interactiveNodes.process_mode = Node.PROCESS_MODE_DISABLED
    pass

func _on_close_check_area_entered(area:Area2D) -> void:
    if (area.is_in_group("player")):
            close = true


func _on_close_check_area_exited(area:Area2D) -> void:
    if (area.is_in_group("player")):
            close = false

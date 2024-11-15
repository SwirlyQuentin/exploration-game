extends Node2D

@onready var switch1 = $InteractiveNodes/Switch1
@onready var switch2 = $InteractiveNodes/Switch2
@onready var interactiveNodes = $InteractiveNodes

@onready var reward = $Reward


var active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.connect("checkSwitch", checkSolve)
	pass



func _on_active_check_body_entered(body:Node2D) -> void:
	if (body.is_in_group("player")):
		active = true


func _on_active_check_body_exited(body:Node2D) -> void:
	if (body.is_in_group("player")):
		active = false

func checkSolve():
	if (switch1.enabled && switch2.enabled):
		#Mark as Solved
		print("SOLVED")
		reward.unlockReward()
		interactiveNodes.process_mode = Node.AUTO_TRANSLATE_MODE_DISABLED
		pass
	pass

func solve():
	pass

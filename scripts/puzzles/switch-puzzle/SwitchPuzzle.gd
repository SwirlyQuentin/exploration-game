extends Node2D

@onready var switch1 = $Switch1
@onready var switch2 = $Switch2


var active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.connect("checkSwitch", solve)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_active_check_body_entered(body:Node2D) -> void:
	if (body.is_in_group("player")):
		active = true


func _on_active_check_body_exited(body:Node2D) -> void:
	if (body.is_in_group("player")):
		active = false

func solve():
	if (switch1.enabled && switch2.enabled):
		#Mark as Solved
		print("SOLVED")
		self.process_mode = Node.PROCESS_MODE_DISABLED
		pass
	pass

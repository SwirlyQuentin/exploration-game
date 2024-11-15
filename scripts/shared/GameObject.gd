extends Node2D
@onready var child: Node2D = self.get_child(0)

@export var isPuzzle = false

var enabled = false

func _ready():
	print("child ", child)
	setDisabled()

func setEnabled():
	child.process_mode = Node.PROCESS_MODE_INHERIT
	child.visible = true
	enabled = true

func setDisabled():
	enabled = false
	child.visible = false
	child.process_mode = Node.PROCESS_MODE_DISABLED

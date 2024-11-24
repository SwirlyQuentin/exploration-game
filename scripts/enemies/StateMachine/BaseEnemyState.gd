extends Node

class_name BaseEnemyState

signal StateTransition

var stateMachine = null
var previousState = null
var stateName = "state"

func _ready():
    self.process_mode = Node.PROCESS_MODE_DISABLED

func enter() -> void:
    pass

func exit() -> void:
    self.process_mode = Node.PROCESS_MODE_DISABLED
    pass


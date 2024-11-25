extends Node

class_name BaseEnemyState

signal StateTransition

var stateMachine = null
var previousState = null
var stateName = "state"

func _ready():
    pass

func enter() -> void:
    pass

func exit() -> void:
    pass


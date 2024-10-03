extends Node

@onready var testState = $TestState

var states = {}
var current_state: BaseState = null

func _ready() -> void:
	add_state("testState", testState)
	change_state("testState")
	pass

func add_state(state_name: String, state: BaseState) -> void:
	states[state_name] = state
	state.state_machine = self

func change_state(new_state_name: String) -> void:
	if current_state:
		current_state.exit()

	current_state = states[new_state_name]
	current_state.enter()
    
	emit_signal("state_changed", current_state)
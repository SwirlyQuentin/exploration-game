extends Node

class_name StateMachine


@onready var chartacter = self.get_parent()

var states = {}
var currentState = null
var currentStateKey = null


func _ready() -> void:
    var parent = get_parent()
    for state in self.get_children():
        state.stateMachine = self
        state.character = chartacter
        state.connect("StateTransition", parent.transitionCheck)
        add_state(state)
        if (currentState):
            remove_child(state)
        else:
            currentState = state
    pass

func add_state(state) -> void:
    states[state.stateName] = state
    state.stateMachine = self

func change_state(newStateName: String) -> void:
    if currentState:
        currentState.exit()

    currentState = states[newStateName]
    add_child(currentState)
    currentState.enter()
    
    emit_signal("state_changed", currentState)

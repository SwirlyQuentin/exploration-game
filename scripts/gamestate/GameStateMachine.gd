extends Node

@onready var testState = $TestState
@onready var gameState = $GameState
@onready var tutorialState = $TutorialState
@onready var bar = $Bar
@onready var metal = $MetalShop
@onready var ware = $Warehouse
@onready var menu = $Menu

var states = {}
var current_state: BaseState = null

func _ready() -> void:
	Signals.connect("changeState", change_state)
	add_state("testState", testState)
	add_state("gameState", gameState)
	add_state("tutState", tutorialState)
	add_state("bar", bar)
	add_state("metalShop", metal)
	add_state("warehouse", ware)
	add_state("menu", menu)
	change_state("menu")
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

extends Node

@onready var children = self.get_children()
var locations = []
var currentScene = ""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	formatCollectables()
	Signals.loadLocations.connect(loadLocations)
	pass # Replace with function body.


func formatCollectables():
	for child in children:
		locations.append({"name":child.name, "position":child.global_position, "scene":currentScene, "active":true, "type": "collectable"})
	pass

func loadLocations():
	for location in locations:
		WorldLoader.locations.append(location)
	pass
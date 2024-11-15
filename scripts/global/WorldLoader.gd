extends Node


@onready var collectable = preload("res://scenes/shared/Collectable.tscn")


var collectableContainer

var worldData
var locations = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.connect("writeWorldLocations", writeLocations)
	Signals.connect("loadObjects", loadCollectables)
	Signals.connect("saveWorld", saveWorld)
	collectWorldData()

	pass # Replace with function body.


func collectWorldData():
	var worldFile = FileAccess.open("res://data/world/world-data/world.json", FileAccess.READ)
	worldData = JSON.parse_string(worldFile.get_as_text())

func loadCollectables():
	collectableContainer = get_tree().current_scene.get_node("Collectables")
	print("container", collectableContainer)
	print("collectable ", collectable)
	for colPos in worldData["collectables"]:
		var c = collectable.instantiate()
		collectableContainer.add_child(c)
		c.position = colPos["location"]
	print("container", collectableContainer)
	pass

func writeLocations():
	worldData["collectables"] = []
	worldData["chests"] = []
	for location in locations:
		if (location["type"] == "collectable"):
			worldData["collectables"].append({"name": location["name"], "location": location["position"], "ref":location["ref"], "active":true})
		elif (location["type"] == "chests"):
			worldData["chests"].append({"name": location["name"], "location": location["position"], "ref":location["ref"], "active":true})
		elif (location["type"] == "puzzles"):
			worldData["puzzles"].append({"name": location["name"], "location": location["position"], "ref":location["ref"], "active":true, "solved":false})
		elif (location["type"] == "enemies"):
			worldData["enemies"].append({"name": location["name"], "location": location["position"], "ref":location["ref"], "active":true})

	print(worldData)


	saveWorld()
	pass

func saveWorld():
	var saveFile = FileAccess.open("res://data/world/world-data/world.json", FileAccess.WRITE)
	saveFile.store_string(JSON.stringify(worldData))
	DevConsole.log("Saved")

func appendCollectables(collectables):
	for col in collectables:
		locations.append(col)
	Signals.emit_signal("writeWorldLocations")
	pass
extends Node


var data = {"exp": 0, "level": 1, "gold": 0, "collectables": [], "totalCollectables": 0}


var maxLevel = 50
var levelExp = {"1": 10}
var exitSpace = null
var bubbleLoc = null
var forgeSolved = false
var health = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.connect("addGold", addGold)
	Signals.connect("addExp", addExp)
	Signals.connect("addCollectable", addCollectable)
	pass # Replace with function body.


func addExp(amount):
	data["exp"] += amount
	checkLevelUp()
	pass

func addGold():
	pass

func checkLevelUp():
	if (int(data["level"]) == 50):
		return
	elif (data["exp"] > levelExp[str(data["level"])]):
		data["exp"] = data["exp"] - levelExp[str(data["level"])]
		data["level"] += 1


func addCollectable():
	# data["collectables"].append(col)
	data["totalCollectables"] += 1
	# col.queue_free()
	pass

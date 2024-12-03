extends Node
@onready var spawnpoint = $PlayerSpawn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (PlayerManager.exitSpace == null):
		PlayerManager.exitSpace = spawnpoint.global_position
	Signals.emit_signal("placeWorld")
	Signals.emit_signal("loadObjects")
	Signals.emit_signal("emitCurrentQuestSignal")
	Signals.emit_signal("emitQueue")

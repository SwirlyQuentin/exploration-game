extends Node


func _ready():
    Signals.emit_signal("completeObj", "hideout-visited", true)
    Signals.emit_signal("emitCurrentQuestSignal")
    Signals.emit_signal("emitQueue")
    Signals.emit_signal("startCutscene", "bossCutscene_part1")
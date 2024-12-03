extends Node


func _ready():
    Signals.emit_signal("tutorial")
    Signals.emit_signal("completeObj", "bar-visited", true)
    Signals.emit_signal("emitCurrentQuestSignal")
    Signals.emit_signal("emitQueue")
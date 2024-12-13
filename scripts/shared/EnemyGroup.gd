extends Node2D

@export var objective:String
@export var willComplete:bool
@export var aggroOnSpawn:bool = false

signal enemyDied

var enemies = 0

func _ready():
    var children = self.get_children()
    var size = 0
    for child in children:
        if ("deathSignal" in child):
            child.deathSignal.connect(checkGroup)
            size += 1
    enemies = size
    enemyDied.connect(checkGroup)

    if (aggroOnSpawn):
        var player = get_tree().get_nodes_in_group("player")[0]
        if (player != null):
            for child in children:
                if ("health" in child):
                    child.activate(player)


func checkGroup():
    enemies -= 1
    if (enemies <= 0):
        Signals.emit_signal("completeObj", objective)
        if(willComplete):
            Signals.emit_signal("completeTimer")
    pass
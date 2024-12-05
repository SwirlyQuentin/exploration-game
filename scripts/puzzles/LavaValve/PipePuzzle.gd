extends Node2D

@onready var reward = $Reward
@onready var pipes = $Pipes

@export var isStory:bool
@export var obj:String
var allPipes = null

func _ready():
    Signals.connect("checkPipes", checkPipes)
    allPipes = pipes.get_children()


func checkPipes():
    var solved = true
    for pipe in allPipes:
        if (int(pipe.currentRotation )not in pipe.correctRotations):
            print(pipe.correctRotations, "   ", pipe.currentRotation)
            solved = false
    if (solved):
        solve()
    
    pass

func solve():
    if (isStory):
        Signals.emit_signal("completeObj", obj, true)
    # reward.unlockReward()
    PlayerManager.forgeSolved = true
    pipes.process_mode = Node.PROCESS_MODE_DISABLED
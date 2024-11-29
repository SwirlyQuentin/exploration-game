extends Node

@onready var player = $Canvas/DialoguePlayer
@onready var actorContainer = $Canvas/DialoguePlayer/Actors
@onready var bubblePlayer = $Bubble


func _ready():
    Signals.connect("startCutscene", playCutscene)
    Signals.connect("startBubble", playBubble)
    Signals.connect("cutsceneFinished", cutsceneFinished)


func playBubble(bubble):
    var loadFile = FileAccess.open("res://data/dialogue/bubbles/" + bubble + ".json", FileAccess.READ)
    if (loadFile != null):
        var data = JSON.parse_string(loadFile.get_as_text())
        bubblePlayer.loadBubble(data)
    pass

func playCutscene(cutscene):
    #check if cutscene is already played
    #load actors
    print("CUTSCENE ", cutscene)
    var loadFile = FileAccess.open("res://data/dialogue/" + cutscene + ".json", FileAccess.READ)
    if (loadFile != null):
        get_tree().paused = true
        var data = JSON.parse_string(loadFile.get_as_text())
        for actor in data["actors"]:
            if (actor["source"].split(".")[1] == "tscn"):
                print("adding actor ", actor["name"])
                addActor(actor["source"])
            else:
                print("CREATE ACTOR")
        player.visible = true
        player.loadCutscene(cutscene)
    else:
        DevConsole.log("Invalid Cutscene")
        cutsceneFinished("none")
    pass
    

func cutsceneFinished(currentCutscene):
    print("seen finsihed")
    cleanCutscene()

func addActor(source:String):
    var sourceScene:PackedScene = load(source)
    var a = sourceScene.instantiate()
    actorContainer.add_child(a)

func cleanCutscene():
    get_tree().paused = false
    for actor in actorContainer.get_children():
        actor.queue_free()
    player.visible = false
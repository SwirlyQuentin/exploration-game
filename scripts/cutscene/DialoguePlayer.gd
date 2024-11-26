extends Control

@onready var leftBox = $LeftDialogue
@onready var rightBox = $RightDialogue
@onready var centerBox = $CenterDialogue

@onready var positions = {"left": leftBox, "right": rightBox, "center": centerBox}
@onready var positionNodes = [leftBox, rightBox, centerBox]

@onready var actors
@onready var actorContainer = $Actors
# @onready var actorLibrary = $ActorLibrary

var data = {}
var dialogueIndex = 0
var playing = false
var currentDialogue = null
var pastGroup = null
var pastGroupNode = null
var currentCutscene = null
@export var cutsceneSource:JSON = null

func _ready():
    leftBox.visible = false
    rightBox.visible = false
    centerBox.visible = false
    pass

    ##CHANBGE ACTORS FUNCTION
    ##RELOAD PLAYER WITH NEW DATA FUNCTION
# func changeActors():
#     if (pastGroup != null):
#         for actor in actors:
#             actorContainer.remove_child(actor)
#             pastGroupNode.add_child(actor)
#     var actorGroup = data["actor-group"]
#     var currentActorGroup = actorLibrary.find_child(actorGroup)
#     actors = currentActorGroup.get_children()
#     for actor in actors:
#         currentActorGroup.remove_child(actor)
#         actorContainer.add_child(actor)
#     pastGroup = actorGroup
#     pastGroupNode = currentActorGroup
#     pass


func loadCutscene(source):
    print(source)
    actors = $Actors.get_children()
    currentCutscene = source
    var loadFile = FileAccess.open("res://data/dialogue/" + source + ".json", FileAccess.READ)
    if (loadFile != null):
        dialogueIndex = 0
        data = JSON.parse_string(loadFile.get_as_text())
        # changeActors()
        loadActors()
        play()
    else:
        DevConsole.log("Invalid Cutscene")
    pass

func loadActors():
    var index = 0
    for actor in actors:
        data["actors"][index]["actor-ref"] = actor
        index += 1
        pass

    #COULD BE FIXED
    for boxPositions in positions.keys():
        for actor in data["actors"]:
            positions[boxPositions].addActor(actor)

    #initial actor setup
    for actor in actors:
        actor.visible = false

func play():
    playing = true
    nextDialogue()
    pass

func nextDialogue():
    if (currentDialogue):
        positions[currentDialogue["direction"]].visible = false
        for actor in actors:
            actor.visible = false
    if (dialogueIndex == data["dialogue"].size()):
        for actor in actors:
            actor.visible = false
        playing = false
        Signals.emit_signal("cutsceneFinished", currentCutscene)
        return
    currentDialogue = data["dialogue"][dialogueIndex]
    positions[currentDialogue["direction"]].visible = true
    positions[currentDialogue["direction"]].loadData(currentDialogue)
    dialogueIndex += 1
    pass

func _input(event):
    if (event.is_action_released("advance-dialogue") && playing):
        nextDialogue()
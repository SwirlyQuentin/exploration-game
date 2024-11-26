extends Control
@onready var actorText = $Dialogue/ActorText
@onready var actorAttachPoint = $AttachPoint


var actors = []

func loadData(data):
    var currentActor = null
    for actor in actors:
        if (data["key"] == actor["actor-key"]):
            currentActor = actor
    currentActor["actor-ref"].visible = true
    currentActor["actor-ref"].setPosition(actorAttachPoint.global_position)
    actorText.text = data["content"]
    print("through")
    pass

func addActor(newActor):
    actors.append(newActor)
    pass
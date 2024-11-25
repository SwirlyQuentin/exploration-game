extends BaseEnemyState

var character = null

var target = null


func _ready():
    stateName = "return"

func enter():
    character.target = null

func _process(delta):
    var finalDirection = (character.originalPos - character.global_position).normalized()
    if ((character.global_position - character.originalPos).length() <= 1):
        character.transition("idle")

    character.dir = finalDirection
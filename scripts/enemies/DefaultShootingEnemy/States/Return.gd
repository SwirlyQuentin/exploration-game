extends BaseEnemyState

var character = null
var target = null

func _ready():
    stateName = "return"
    pass
func enter():
    print("entered return")
    character.returning = true
    character.speedMod = 2

func exit():
    character.returning = false
    character.speedMod = 1

func _physics_process(delta):
    if ((character.originalPos - character.global_position).length() < 5):
        stateMachine.change_state("idle")

    # character.dir = (character.originalPos - character.global_position).normalized()
    character.navTarget = character.originalPos
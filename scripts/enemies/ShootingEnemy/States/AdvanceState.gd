extends BaseEnemyState

var character = null

var target = null
var targetPos = Vector2()
var meleeTimer = 0


func _ready():
    stateName = "advance"

func enter():
    target = character.target
    targetPos = target.global_position
    character.speedMod = 2
    meleeTimer = 7

func exit():
    character.speedMod = 1

func _process(delta):
    if (target != null):
        meleeTimer -= delta

        if ((character.global_position - targetPos).length() <= 30 || meleeTimer <= 0):
            character.transition("melee")
            pass
        elif ((character.global_position - targetPos).length() >= 100):
            targetPos = target.global_position
            pass

        character.dir = (targetPos - character.global_position).normalized()

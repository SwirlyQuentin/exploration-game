extends BaseEnemyState

var character = null
var target = null
var follow = false


func _ready():
    stateName = "attacking"
    pass

func enter():
    target = character.target
    character.gun.enableShooting(target)

func exit():
    character.gun.disableShooting()

func _physics_process(delta):

    checkFollow()

    if (follow):
        # character.dir = (target.global_position - character.global_position).normalized()
        character.navTarget = target.global_position
    else:
        # character.dir = Vector2.ZERO
        character.navTarget = Vector2.ZERO

func checkFollow():
    var targetDistance = (target.global_position - character.global_position).length()
    if (targetDistance > character.followRange):
        follow = true
        character.gun.disableShooting()
    else:
        character.gun.enableShooting()
    if (targetDistance < character.sweetSpot):
        follow = false


extends BaseEnemyState

@export var stopDistance:float = 10

var character = null
var target = null
var follow = false



func _ready():
    stateName = "attacking"
    pass



func enter():
    target = character.target
    character.melee.enableAttack(target)

func exit():
    character.melee.disableAttack()


func _physics_process(delta):
    if ((target.global_position - character.global_position).length() > stopDistance):
        character.navTarget = target.global_position
    else:
        character.navTarget = Vector2.ZERO

extends BaseEnemyState

var character = null

var target = null
var meleeTimer = 0


func _ready():
    stateName = "melee"

func enter():
    target = character.target
    meleeTimer = 1.5
    
func _process(delta):
    character.dir = Vector2.ZERO
    meleeTimer -= delta
    if (meleeTimer <= 0):
        character.transition("retreat")
    # if (target != null && !character.melee.attacking):
    #     character.melee.hit(target)
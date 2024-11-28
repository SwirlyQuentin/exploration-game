extends BaseEnemyState

var character = null

var target = null
var meleeTimer = 0
var meleeDelay = 0
var hit = false


func _ready():
    stateName = "melee"

func enter():
    target = character.target
    meleeTimer = 0.5
    meleeDelay = 0.5
    hit = false
    
func _process(delta):
    character.dir = Vector2.ZERO
    meleeDelay -= delta
    if (meleeDelay <= 0 && !hit):
        print("SMACKED")
        character.melee.hit(target)
        hit = true
    if (hit):
        meleeTimer -= delta
        if (meleeTimer <= 0):
            character.transition("retreat")
    # if (target != null && !character.melee.attacking):
    #     character.melee.hit(target)
extends BaseEnemyState

var character = null

var target = null
var meleeTimer = 0
var targetPos = Vector2()
var finalDirection = Vector2()
var halfRange = 260
var retreatTimer = 0


func _ready():
    stateName = "retreat"

func enter():
    target = character.target
    if target != null:
        targetPos = target.global_position
        retreatTimer = 3

func _process(delta):
    if (target!= null):
        retreatTimer -= delta
        finalDirection = (character.global_position - targetPos).normalized()
        if ((character.global_position - targetPos).length() >= halfRange || retreatTimer <= 0):
            character.transition("base")

        if (target != null && !character.gun.shooting):
            character.gun.shoot(target)
        
        character.dir = finalDirection

    pass
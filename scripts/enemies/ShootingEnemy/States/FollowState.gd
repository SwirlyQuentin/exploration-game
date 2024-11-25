extends BaseEnemyState

var character = null

var target = null


func _ready():
    stateName = "follow"

func enter():
    target = character.target


func _process(delta):
    if (target != null):
        var finalDirection = (target.global_position - character.global_position).normalized()
        if ((target.global_position - character.global_position).length() <= character.gun.sweetSpot):
            character.transition("base")

        if (target != null && !character.gun.shooting):
            character.gun.shoot(target)

        character.dir = finalDirection
extends BaseEnemyState

var character = null

var target = null


func _ready():
	stateName = "baseShooting"

func enter():
	target = character.target


func _process(delta):
	character.dir = Vector2.ZERO
	if (target != null && !character.gun.shooting):
		character.gun.shoot(target)

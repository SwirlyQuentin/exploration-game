extends BaseEnemyState

var character = null

var target = null
var stateTimer = 0
var states = ["advance", "strafe"]


func _ready():
	stateName = "baseShooting"

func enter():
	target = character.target
	stateTimer = randf_range(2, 3.5)


func _process(delta):
	stateTimer -= delta
	checkNewState()
	character.dir = Vector2.ZERO
	if (target != null && !character.gun.shooting):
		character.gun.shoot(target)


func checkNewState():
	if (stateTimer <= 0):
		var randomState  = states.pick_random()
		print("random state ", randomState)
		if (randomState == "baseShooting"):
			stateTimer = randf_range(2, 3.5)
		else:
			character.transition(randomState)

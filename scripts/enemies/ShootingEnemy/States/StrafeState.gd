extends BaseEnemyState

var character = null

var target = null
var switchTimer = 0
var sideLimit = 150
var originalPos = Vector2()
var turnAngle = 90
var finalDirection = Vector2()
var returning = false

var stateTimer = 0

func enter():
    originalPos = character.global_position
    target = character.target
    stateTimer = randf_range(3, 5)
    pass


func _ready():
    stateName = "strafe"

func _process(delta):
    stateTimer -= delta
    if (stateTimer <= 0):
        character.transition("base")
    if (target != null):
        switchTimer -= delta
        
        if (switchTimer <= 0):
            switchTimer = randf_range(1.5, 2)
            turnAngle = -turnAngle
            print("SWAPPED " , deg_to_rad(turnAngle))
            pass

        var toTarget = character.global_position - target.global_position
        finalDirection = toTarget.rotated(deg_to_rad(turnAngle)).normalized()

    
        if ((character.global_position - originalPos).length() < 1):
            returning = false

        if ((character.global_position - originalPos).length() > sideLimit || returning):
            finalDirection = (originalPos - character.global_position).normalized()
            returning = true
            pass
    character.dir = finalDirection
    if (target != null && !character.gun.shooting):
        character.gun.shoot(target)

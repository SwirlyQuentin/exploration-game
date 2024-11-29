extends EnemyBase 
@onready var gun = $Holster.get_child(0)
@onready var melee = $Melee.get_child(0)
@onready var activeCheck = $ActiveCheck
@onready var stateMachine = $ShootingEnemySM
@onready var enemyAlert:Area2D = $EnemyAlert

var dir = Vector2()
var perlin = Vector2()
var speed = 7000
var speedMod = 1
var tetherRange = 1500

var originalPos = Vector2()

var idle = true
var target = null



func _ready():
    originalPos = self.global_position
    prepHealthBar()

    pass

func _physics_process(delta):

    if ((self.global_position - originalPos).length() >= tetherRange):
        transition("return")
    if (target != null):
        if ((self.global_position - target.global_position).length() >= gun.enemyRange):
            if (stateMachine.currentState.stateName != "follow"):
                transition("follow")
    
    velocity = dir * speed * speedMod * delta
    move_and_slide()


func transition(sig):
    # print("changing ", sig)
    if (sig == "active"):
        idle = false
        activeCheck.process_mode = Node.PROCESS_MODE_DISABLED
        stateMachine.change_state("baseShooting")
    elif (sig == "retreat"):
        stateMachine.change_state("retreat")
    elif (sig == "melee"):
        stateMachine.change_state("melee")
    elif (sig == "base"):
        stateMachine.change_state("baseShooting")
    elif (sig == "advance"):
        stateMachine.change_state("advance")
    elif (sig == "return"):
        stateMachine.change_state("return")
    elif (sig == "strafe"):
        stateMachine.change_state("strafe")
    elif (sig == "follow"):
        stateMachine.change_state("follow")
    elif (sig == "idle"):
        stateMachine.change_state("idle")
        idle = true
        activeCheck.process_mode = Node.PROCESS_MODE_INHERIT

func transitionCheck(sig):
    print(sig)

func _on_active_check_body_entered(body:Node2D) -> void:
    if (body.is_in_group("player")):
        target = body
        melee.target = body
        transition("active")
        for enemy in enemyAlert.get_overlapping_bodies():
            enemy.alert(body)
        

    
func alert(tar):
    if (target == null):
        target = tar
        transition("active")
        for enemy in enemyAlert.get_overlapping_bodies():
            enemy.alert(tar)




func _on_close_area_entered(area:Area2D) -> void:
    if (area.is_in_group("player") && target != null):
        transition("advance")


func _on_active_check_area_entered(area:Area2D) -> void:
    if (area.is_in_group("player")):
        target = area
        melee.target = area
        transition("active")
        for enemy in enemyAlert.get_overlapping_bodies():
            enemy.alert(area)

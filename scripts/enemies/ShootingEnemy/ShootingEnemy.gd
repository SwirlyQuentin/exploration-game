extends EnemyBase 
@onready var gun = $Holster.get_child(0)
@onready var activeCheck = $ActiveCheck
@onready var stateMachine = $ShootingEnemySM

var dir = Vector2()
var perlin = Vector2()
var speed = 7000
var speedMod = 1
var tetherRange = 1500

var originalPos = Vector2()

var line
var line2
var idle = true
var target = null



func _ready():
    prepHealthBar()
    originalPos = self.global_position
    line = Line2D.new()
    self.add_child(line)
    line.show()

    # line2 = Line2D.new()
    # self.add_child(line2)
    # line2.show()
    # line2.default_color = Color("ff91c7")
    pass

func _physics_process(delta):

    if ((self.global_position - originalPos).length() >= tetherRange):
        transition("return")
    if (target != null):
        if ((self.global_position - target.global_position).length() >= gun.enemyRange):
            if (stateMachine.currentState.stateName != "follow"):
                transition("follow")

    line.clear_points()
    line.add_point(line.position)
    line.add_point( dir * 50 - line.position)

    # line2.clear_points()
    # line2.add_point(line2.position)
    # line2.add_point( perlin * 50 - line2.position)
    
    velocity = dir * speed * speedMod * delta
    move_and_slide()


func transition(sig):
    print("changing ", sig)
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
        transition("active")
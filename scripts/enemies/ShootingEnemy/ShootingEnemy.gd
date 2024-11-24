extends CharacterBody2D 
@onready var gun = $Holster.get_child(0)
@onready var activeCheck = $ActiveCheck
@onready var stateMachine = $ShootingEnemySM

var dir = Vector2()
var perlin = Vector2()
var speed = 2000

var originalPos = Vector2()

var line
var line2
var idle = true
var target = null


func _ready():
    originalPos = self.global_position
    # line = Line2D.new()
    # self.add_child(line)
    # line.show()

    # line2 = Line2D.new()
    # self.add_child(line2)
    # line2.show()
    # line2.default_color = Color("ff91c7")
    pass

func _physics_process(delta):
    if (!idle):
        activeCheck.process_mode = Node.PROCESS_MODE_DISABLED

    # line.clear_points()
    # line.add_point(line.position)
    # line.add_point( dir * 50 - line.position)

    # line2.clear_points()
    # line2.add_point(line2.position)
    # line2.add_point( perlin * 50 - line2.position)
    
    velocity = dir * speed * delta
    move_and_slide()


func transition(sig):
    if (sig == "active"):
        idle = false
        stateMachine.change_state("baseShooting")

func transitionCheck(sig):
    print(sig)

func _on_active_check_body_entered(body:Node2D) -> void:
    if (body.is_in_group("player")):
        target = body
        transition("active")
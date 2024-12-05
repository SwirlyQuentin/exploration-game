extends EnemyBase

@export var speed:int = 3000
@export var followRange:int = 500
@export var sweetSpot = 200
@export var tetherLength:int = 900

@onready var gun = $Holster
@onready var melee = $Melee
@onready var enemyAlert:Area2D = $EnemyAlert
@onready var sm = $StateMachine
@onready var activeCheck = $ActiveCheck
@onready var navAgent = $NavAgent
@onready var sprite = $Sprite



var dir = Vector2()
var navTarget = Vector2()
var speedMod = 1
var returning = false

var originalPos = Vector2()
var perlin = Vector2()


var idle = true
var target = null

func _ready():
    
    if (gun):
        gun = gun.get_child(0)
        followRange = gun.gunRange

    if (melee):
        melee = melee.get_child(0)

    originalPos = self.global_position
    prepHealthBar()


func _physics_process(delta):
    flipSprite()
    checkFar()
    navAgent.target_position = navTarget
    if (navTarget == Vector2.ZERO):
        dir = Vector2.ZERO
    else:
        dir = (navAgent.get_next_path_position() - global_position).normalized()
    velocity = dir * speed * speedMod * delta
    # velocity = velocity.lerp(dir * speed, delta)
    move_and_slide()



func activate(tar):
    activeCheck.process_mode = Node.PROCESS_MODE_DISABLED
    target = tar
    for enemy in enemyAlert.get_overlapping_bodies():
        enemy.alert(target)
    sm.change_state("attacking")

func alert(tar):
    if (target == null):
        target = tar
        for enemy in enemyAlert.get_overlapping_bodies():
            enemy.alert(tar)
        sm.change_state("attacking")

func checkFar():
    if ((originalPos - global_position).length() > tetherLength && !returning):
        print("too far")
        sm.change_state("return")
    pass

func takeDamage(damage, character = null):
    if (character != null):
        activate(character)
    if (hitFlash != null):
        hitFlash.play("hit")
    currentTotalDamage += damage
    health -= damage
    healthBar.value = health
    damaging = true
    damageTimer = 0
    damageNumbers.text = str(currentTotalDamage)
    if (health <= 0):
        die()
    
    pass

func flipSprite():
    if (target == null):
        if velocity.x < 0:
            sprite.flip_h = true
        elif (velocity.x > 0):
            sprite.flip_h = false 
    else:
        var toTarget = target.global_position - self.global_position
        if toTarget.x < 0:
            sprite.flip_h = true
        elif (toTarget.x > 0):
            sprite.flip_h = false 
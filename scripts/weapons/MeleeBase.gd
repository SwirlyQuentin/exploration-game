extends Node2D

class_name MeleeBase

@export var hitCooldown:float = 3
@export var hitRange:float = 20
@export var hitPause:float = 0.2
@export var damage:float = 10


var pauseTimer = hitPause
var timer = 0


var attacking = false
var target = null


func enableAttack(tar):
    attacking = true
    target = tar
    pass

func disableAttack():
    attacking = false
    pass

func _physics_process(delta):
    if (attacking && target != null):
        if ((self.global_position - target.global_position).length() < hitRange):
            pauseTimer -= delta
            if (pauseTimer <= 0 && timer <= 0):
                attack()
        else:
            pauseTimer = hitPause
    timer -= delta

func attack():
    pauseTimer = hitPause
    timer = hitCooldown
    target.health.takeDamage(damage)
    
    pass
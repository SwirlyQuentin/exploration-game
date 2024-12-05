extends Node2D

class_name GunBase

@export var shootingCooldown:float = 3
@export var gunRange:int = 400

@onready var shootingPoint = $ShootingPoint
@onready var bullets = self.get_tree().current_scene

var shooting = false
var target = null
@onready var timer = shootingCooldown/2


func enableShooting(tar = null):
    shooting = true
    if (tar != null):
        target = tar

func disableShooting():
    shooting = false


func _physics_process(delta):
    if (shooting && target != null):
        if (timer <= 0):
            shoot()
    timer -= delta


func shoot():
    timer = shootingCooldown
    pass
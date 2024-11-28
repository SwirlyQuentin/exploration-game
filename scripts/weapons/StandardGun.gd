extends Node2D
@onready var bullet = preload("res://scenes/Weapons/StandardBullet.tscn")
@onready var shootingPoint = $ShootingPoint
@onready var bullets = $Bullets

var totalShots = 3
var target = null
var angleDifference = -10
var currentShots = 0
var shooting = false
var shotTimer = 0.2
var timer = 0
var ableToShoot = false
var cooldown = 2.5
var cooldownTimer = 0

var enemyRange = 700
var sweetSpot = 300


func shoot(target):
    if (cooldownTimer <= 0):
        angleDifference = -20
        self.target = target
        shooting = true
        ableToShoot = true
        timer = 0
    pass

func _process(delta):
    if (shooting):
        if (timer <= 0):
            ableToShoot = true
        timer -= delta
        if (ableToShoot):
            var b = bullet.instantiate()
            bullets.add_child(b)
            b.position = shootingPoint.global_position
            b.direction = (target.global_position - shootingPoint.global_position).rotated(deg_to_rad(angleDifference))
            currentShots += 1
            angleDifference += 10
            ableToShoot = false
            timer = shotTimer

        if (currentShots >= totalShots):
            shooting = false
            currentShots = 0
            cooldownTimer = cooldown
    else:
        cooldownTimer -= delta

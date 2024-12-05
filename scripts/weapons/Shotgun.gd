extends GunBase

@export var pellets:int = 3

@onready var bullet = preload("res://scenes/Weapons/StandardBullet.tscn")

var startingShotAngle = -10

func shoot():
    timer = shootingCooldown - randf_range(0, 0.7)
    var angle = startingShotAngle
    for i in range(pellets):
        var b = bullet.instantiate()
        bullets.add_child(b)
        b.position = shootingPoint.global_position
        b.direction = (target.global_position - shootingPoint.global_position).rotated(deg_to_rad(angle))
        angle += 10
    pass

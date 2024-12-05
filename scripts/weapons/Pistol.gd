extends GunBase

@onready var bullet = preload("res://scenes/Weapons/StandardBullet.tscn")


func shoot():
    timer = shootingCooldown - randf_range(0, 0.3)
    var b = bullet.instantiate()
    bullets.add_child(b)
    b.position = shootingPoint.global_position
    b.direction = (target.global_position - shootingPoint.global_position)
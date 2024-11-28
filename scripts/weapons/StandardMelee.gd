extends Node2D

@onready var hitbox:Area2D = $Hitbox

var target = null
var damage = 20
var boxDist = 35

func hit(tar):
    self.target = tar
    if target.hitBox in hitbox.get_overlapping_areas():
        target.health.takeDamage(damage)


func _process(delta):
    if (target != null):
        var tar = (target.global_position - self.global_position).normalized()
        tar *= boxDist
        hitbox.position = tar
        hitbox.rotation = get_angle_to(target.global_position)

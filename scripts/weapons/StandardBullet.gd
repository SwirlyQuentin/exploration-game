extends Area2D
# @onready var bulletCheck:RayCast2D = $BulletCheck

var direction = Vector2()
var speed = 200
var duration = 5
var startDuration = 0
var damage = 5

# var line:Line2D

# func _ready():
# 	line = Line2D.new()
# 	self.add_child(line)
# 	line.show()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    startDuration += delta
    if (startDuration > duration):
        self.queue_free()

    # line.position = bulletCheck.position
    # line.clear_points()
    # line.add_point(line.position)
    # line.add_point(line.position - bulletCheck.target_position)
    
    # bulletCheck.target_position = bulletCheck.global_position - (self.global_position + speed * direction.normalized() * delta)
    # if (bulletCheck.is_colliding()):
    # 	self.global_position = bulletCheck.get_collision_point()
    # else:
    # 	self.global_position += speed * direction.normalized() * delta
    # pass

    self.global_position += speed * direction.normalized() * delta


func _on_body_entered(body:Node2D) -> void:
    if (body.is_in_group("player")):
        body.takeDamage(damage)
        queue_free()

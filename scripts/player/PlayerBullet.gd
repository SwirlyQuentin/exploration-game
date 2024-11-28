extends Area2D

@onready var bulletCheck:RayCast2D = $Check/BulletCheck

var direction = Vector2()
var speed = 800
var duration = 5
var startDuration = 0
var damage = 5



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    startDuration += delta
    if (startDuration > duration):
        self.queue_free()

    bulletCheck.position = self.global_position
    # print("BULLETCHECK POS ", bulletCheck.global_position, " SLEF POS ", self.global_position)

    
    bulletCheck.target_position = bulletCheck.global_position - (self.global_position + speed * direction.normalized() * delta)
    # print("TARGET POSITION ", bulletCheck.target_position)
    if (bulletCheck.is_colliding()):
        self.global_position = bulletCheck.get_collision_point()
        var collider = bulletCheck.get_collider()
        if (collider.is_in_group("damagable")):
            collider.takeDamage(damage)
            queue_free()
    else:
        self.global_position += speed * direction.normalized() * delta
    pass


func _on_body_entered(body:Node2D) -> void:
    if (body.is_in_group("damagable")):
        body.takeDamage(damage)
        queue_free()

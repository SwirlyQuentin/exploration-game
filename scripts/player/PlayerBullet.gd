extends Area2D

@onready var bulletCheck:RayCast2D = $Check/BulletCheck
@onready var animation = $AnimationPlayer

var direction = Vector2()
@export var speed = 800
var duration = 5
var startDuration = 0
var damage = 5
var character = null

var exploding = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if (exploding):
        return
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
        if (collider != null):
            if (collider.is_in_group("damagable")):
                explode(collider)
    else:
        self.global_position += speed * direction.normalized() * delta
    pass


func _on_body_entered(body:Node2D) -> void:
    print("bodied")
    if (!body.is_in_group("player")):
        exploding = true
        animation.play("explode")


func _on_area_entered(area:Area2D) -> void:
    # if (area.character.is_in_group("damagable")):
    #     area.character.takeDamage(damage)
    #     queue_free()
    pass


func explode(collider):
    if (!exploding):
        exploding = true
        collider.character.takeDamage(damage, character)
        animation.play("explode")

func _on_animation_player_animation_finished(anim_name:StringName) -> void:
    if (anim_name == "explode"):
        queue_free()

extends CharacterBody2D

@onready var playerBullet = preload("res://scenes/player/PlayerBullet.tscn")
@onready var bulletContainer = $Bullets
@onready var shootingPoint = $Hand/ShootingPoint
@onready var hand = $Hand

const speed = 300.0
var handDistance = 70


func _input(event):
	if (event.is_action_pressed("shoot")):
		shoot()


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	positionHand()

	var xdirection = Input.get_axis("left", "right")
	var ydirection = Input.get_axis("up", "down")
	var direction = Vector2(xdirection, ydirection)

	if (!direction):
		direction.x = move_toward(direction.x, 0, speed)
		direction.y = move_toward(direction.y, 0, speed)


	velocity = direction.normalized() * speed

	move_and_slide()


func _on_render_distance_area_entered(area:Area2D) -> void:
	if (!area.parent.isPuzzle):
		area.parent.setEnabled()
		print("AREA ", area)


func _on_render_distance_area_exited(area:Area2D) -> void:
	if (!area.parent.isPuzzle):
		area.parent.setDisabled()

func shoot():
	var b:Area2D = playerBullet.instantiate()
	bulletContainer.add_child(b)
	b.damage = int(randf_range(3 * (PlayerManager.data["totalCollectables"] + 1) , 6 * (PlayerManager.data["totalCollectables"] + 1)))
	b.global_position = shootingPoint.global_position
	b.direction = get_global_mouse_position() - shootingPoint.global_position
	b.rotation = b.direction.angle() + deg_to_rad(90)
	pass


func positionHand():
	var tar = (get_global_mouse_position() - self.position).normalized()
	tar *= handDistance
	hand.position = tar

	
	pass
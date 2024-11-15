extends CharacterBody2D


const speed = 300.0




func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
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

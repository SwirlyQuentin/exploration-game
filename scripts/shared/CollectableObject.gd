extends Node2D

var initialized = false

var initTimer:Timer = Timer.new()

func _ready():
	# initTimer.wait_time = 1
	# initTimer.one_shot = true
	# initTimer.connect("timeout", initTimerTimeout)
	# initTimer.autostart = true
	# add_child(initTimer)
	# visible = false
	# process_mode = Node.PROCESS_MODE_DISABLED
	pass


func initTimerTimeout():
	print("timeout")
	initialized = true


func _on_collect_check_area_entered(area:Area2D) -> void:
	print("COLLIDED, ", area)
	if (area.is_in_group("player")):
		Signals.emit_signal("addCollectable")
		print("added collectable")
		get_parent().queue_free()

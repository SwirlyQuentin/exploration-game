extends BaseState

func enter() -> void:
	get_tree().change_scene_to_file("res://scenes/mainscenes/Bar.tscn")
	pass
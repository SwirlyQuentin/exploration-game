extends BaseState


func enter() -> void:
    get_tree().change_scene_to_file("res://scenes/mainscenes/MenuScene.tscn")
    pass
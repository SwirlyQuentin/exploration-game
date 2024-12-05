extends Area2D

var parent

func _ready(): 
    parent = self.get_parent()




func _on_area_entered(area:Area2D) -> void:
    if (area.is_in_group("player")):
        if parent.has_method("activate"):
            parent.activate(area.character)

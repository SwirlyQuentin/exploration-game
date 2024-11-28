extends Node
class_name QuestObject

@export var quest:String
@export_enum("enable", "disable") var action:String = "enable"
@onready var parent = self.get_parent()


# var action = "enable"

func _ready():
    QuestSignals.connect(QuestEngine.getSignal(quest), catchSignal)
    disable()

    pass

func catchSignal():
    if (action == "enable"):
        enable()
    elif (action == "disable"):
        disable()
    else:
        print("wrong action")


func enable():
    condEnable()
    parent.process_mode = Node.PROCESS_MODE_INHERIT
    parent.visible = true
    pass

func disable():
    condDisable()
    parent.process_mode = Node.PROCESS_MODE_DISABLED
    parent.visible = false
    pass

func condEnable():
    pass

func condDisable():
    pass

extends Node
class_name QuestObject

@export var quest:String
@export_enum("enable", "disable") var action:String = "enable"
@export var endingQuest:String
@export_enum("enable", "disable") var endAction:String = "disable"
@export var id:String
@onready var parent = self.get_parent()


# var action = "enable"

func _ready():
    QuestSignals.connect(QuestEngine.getSignal(quest), catchSignal)
    if(endingQuest != ""):
        QuestSignals.connect(QuestEngine.getSignal(endingQuest), endObject)
    disable()

    pass

func catchSignal(ids):
    if ids != null && id not in ids:
        return
    Signals.emit_signal("queueQuest", quest, id)
    print("recieved Signal ")
    if (action == "enable"):
        enable()
    elif (action == "disable"):
        disable()
    else:
        print("wrong action")

func endObject(ids):
    if ids != null && id not in ids:
        return
    Signals.emit_signal("removeFromQueue", quest, id)
    print("recieved Signal ")
    if (endAction == "enable"):
        enable()
    elif (endAction == "disable"):
        disable()
    else:
        print("wrong action")
    pass

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


func trigger(trig):
    QuestSignals.emit_signal(trig)

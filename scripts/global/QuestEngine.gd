extends Node

var questData = null
var currentQuest = null

func _ready():
    var questFile = FileAccess.open("res://data/world/quests.json", FileAccess.READ)
    questData = JSON.parse_string(questFile.get_as_text())
    pass


func checkQuest(quest):
    if (!questData["quests"][quest]["completed"]):
        QuestSignals.emit_signal(questData["quests"][quest]["signal"])
        questData["quests"][quest]["completed"] = true


func getSignal(quest):
    return questData["quests"][quest]["signal"]

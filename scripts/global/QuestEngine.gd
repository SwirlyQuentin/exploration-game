extends Node
@onready var questName = $Canvas/QuestTracker/QuestName
@onready var questDesc = $Canvas/QuestTracker/Scroll/QuestDesc
@onready var objectiveContainer = $Canvas/QuestTracker/Objectives/ObjectiveContainer
@onready var objective = preload("res://scenes/shared/UI/Objective.tscn")
@onready var quests = $Canvas/QuestTracker

var questData = null
var currentQuest = null
var questIndex = 0

func _ready():
    hideQuests()
    Signals.connect("tutorialFinished", showQuests)
    Signals.connect("advanceQuest", advanceQuest)
    Signals.connect("completeQuest", completeQuest)
    Signals.connect("completeObj", completeObj)
    var questFile = FileAccess.open("res://data/world/quests.json", FileAccess.READ)
    questData = JSON.parse_string(questFile.get_as_text())
    currentQuest = questData["quests"].keys()[0]
    updateTracker()
    pass


func completeQuest():
    print("Completing")
    print(checkCompletedQuest())
    if (!questData["quests"][currentQuest]["completed"]):
        if (checkCompletedQuest()):
            QuestSignals.emit_signal(questData["quests"][currentQuest]["signal"])
            questData["quests"][currentQuest]["completed"] = true
            advanceQuest()

func completeObj(obj):
    if (obj in questData["quests"][currentQuest]["obj"].keys()):
        questData["quests"][currentQuest]["obj"][obj]["ref"].complete()
        questData["quests"][currentQuest]["obj"][obj]["completed"] = true

func getSignal(quest):
    return questData["quests"][quest]["signal"]

func updateTracker():
    for child in objectiveContainer.get_children():
        objectiveContainer.remove_child(child)
    questName.text = questData["quests"][currentQuest]["name"]
    questDesc.text = questData["quests"][currentQuest]["desc"]
    for obj in questData["quests"][currentQuest]["obj"].keys():
        var o = objective.instantiate()
        objectiveContainer.add_child(o)
        o.updateInfo(questData["quests"][currentQuest]["obj"][obj]["name"])
        questData["quests"][currentQuest]["obj"][obj]["ref"] = o
    
    pass

func showQuests():
    quests.visible = true

func hideQuests():
    quests.visible = false

func advanceQuest():
    if (questData["quests"][currentQuest]["completed"]):
        questIndex += 1
        currentQuest = questData["quests"].keys()[questIndex]
        updateTracker()

func checkCompletedQuest():
    var result = true
    print(questData["quests"][currentQuest]["obj"])
    for obj in questData["quests"][currentQuest]["obj"].keys():
        if !questData["quests"][currentQuest]["obj"][obj]["completed"]:
            result = false
    return result

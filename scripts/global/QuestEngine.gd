extends Node
@onready var questName = $Canvas/QuestTracker/QuestName
@onready var questDesc = $Canvas/QuestTracker/Scroll/QuestDesc
@onready var objectiveContainer = $Canvas/QuestTracker/Objectives/ObjectiveContainer
@onready var objective = preload("res://scenes/shared/UI/Objective.tscn")
@onready var quests = $Canvas/QuestTracker

var questData = null
var currentQuest = null
var previousQuest = null
var questIndex = 0
var questQueue = {}
var foreverObjects = []

var completeTimer = 0
var completeTime = 2

func _ready():
    hideQuests()
    Signals.connect("tutorialFinished", showQuests)
    Signals.connect("advanceQuest", advanceQuest)
    Signals.connect("completeQuest", completeQuest)
    Signals.connect("completeObj", completeObj)
    Signals.connect("emitQueue", emitQueue)
    Signals.connect("queueQuest", queueQuest)
    Signals.connect("removeFromQueue", removeFromQueue)
    Signals.connect("completeTimer", completeOnTimer)
    Signals.connect("emitCurrentQuestSignal", emitCurrentQuestSignal)
    var questFile = FileAccess.open("res://data/world/quests.json", FileAccess.READ)
    questData = JSON.parse_string(questFile.get_as_text())
    currentQuest = questData["quests"].keys()[0]
    createObjectives()
    updateTracker()
    pass


func completeQuest():
    print("Completing")
    print(checkCompletedQuest())
    if (!questData["quests"][currentQuest]["completed"]):
        if (checkCompletedQuest()):
            questData["quests"][currentQuest]["completed"] = true
            advanceQuest()
            createObjectives()
            updateTracker()
            QuestSignals.emit_signal(questData["quests"][currentQuest]["signal"], null)

func completeObj(obj, willComplete = false):
    if (obj in questData["quests"][currentQuest]["obj"].keys()):
        questData["quests"][currentQuest]["obj"][obj]["ref"].complete()
        questData["quests"][currentQuest]["obj"][obj]["completed"] = true
        if (willComplete):
            completeOnTimer()

func getSignal(quest):
    return questData["quests"][quest]["signal"]

func updateTracker():
    if (completeTimer > 0):
        return
    for child in objectiveContainer.get_children():
        objectiveContainer.remove_child(child)
    questName.text = questData["quests"][currentQuest]["name"]
    questDesc.text = questData["quests"][currentQuest]["desc"]
    for obj in questData["quests"][currentQuest]["obj"].keys():
        objectiveContainer.add_child(questData["quests"][currentQuest]["obj"][obj]["ref"])
    
    pass

func createObjectives():
    for obj in questData["quests"][currentQuest]["obj"].keys():
        var o = objective.instantiate()
        add_child(o)
        o.updateInfo(questData["quests"][currentQuest]["obj"][obj]["name"])
        questData["quests"][currentQuest]["obj"][obj]["ref"] = o
        remove_child(o)
    pass

func showQuests():
    quests.visible = true

func hideQuests():
    quests.visible = false

func advanceQuest():
    if (questData["quests"][currentQuest]["completed"]):
        previousQuest = currentQuest
        questIndex += 1
        currentQuest = questData["quests"].keys()[questIndex]

func checkCompletedQuest():
    var result = true
    print(questData["quests"][currentQuest]["obj"])
    for obj in questData["quests"][currentQuest]["obj"].keys():
        if !questData["quests"][currentQuest]["obj"][obj]["completed"]:
            result = false
    return result


func queueQuest(quest, id):
    if (quest not in questQueue):
        questQueue[quest] = []
    if (id not in questQueue[quest]):
        questQueue[quest].append(id)
        print("queued ", quest)
    pass

func removeFromQueue(quest, id):
    if (id in questQueue[quest]):
        questQueue[quest].remove_at(questQueue[quest].find(id))
        print("removed ", id)

func emitQueue():
    print(questQueue)
    for quest in questQueue.keys():
        QuestSignals.emit_signal(questData["quests"][quest]["signal"], questQueue[quest])
        print("clearing queue ", quest)

func completeOnTimer():
    if (checkCompletedQuest()):
        completeTimer = completeTime
        completeQuest()

func _process(delta):
    if (completeTimer > 0):
        completeTimer -= delta
        if (completeTimer <= 0):
            updateTracker()

func emitCurrentQuestSignal():
    QuestSignals.emit_signal(questData["quests"][currentQuest]["signal"], null)
    pass
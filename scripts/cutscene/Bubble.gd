extends Node2D
@onready var bubbleText = $BubbleText

var data = null
var speechTimer = 0
var speechTime = 2
var dialogueIndex = 0

func _ready():
    self.visible = false


func loadBubble(bub):
    self.visible = true
    self.global_position = PlayerManager.bubbleLoc
    self.data = bub
    dialogueIndex = 0
    nextDialogue()

    pass


func nextDialogue():
    if (dialogueIndex < data["dialogue"].size()):
        bubbleText.text = data["dialogue"][dialogueIndex]["content"]
        speechTimer = speechTime
    else:
        finish()
    pass

func finish():
    self.visible = false

func _process(delta):
    if (speechTimer > 0):
        self.global_position = PlayerManager.bubbleLoc
        speechTimer -= delta
        if (speechTimer <= 0):
            dialogueIndex += 1
            nextDialogue()
    pass
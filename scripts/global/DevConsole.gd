extends Node

@onready var console = $Console
@onready var textInput = $Console/Contents/TextInput
@onready var consoleText:RichTextLabel = $Console/Contents/ConsoleText

var pastCommands = []
var dataSignals = []

var visibleState = false
var focused = false

func _ready():
    console.visible = visibleState

func _input(event):
    if (event.is_action_released("show-console")):
        visibleState = !visibleState
        console.visible = visibleState
        textInput.grab_focus()
        textInput.text = ""
    elif (event.is_action_pressed("enter") && focused):
        consoleText.text = consoleText.text + "\n" + textInput.text
        parseConsole()
        textInput.text = ""
        pass


func _on_text_input_focus_entered() -> void:
    focused = true


func _on_text_input_focus_exited() -> void:
    focused = false


func parseConsole():
    var text = textInput.text
    var split = text.split(" ")
    if (split[0] == "emit"):
        if (split[1] in dataSignals):
            self.log("Invalid Call")
        else:
            print("emitted")
            Signals.emit_signal(split[1])
            self.log("Signal Emitted: " + split[1])
    elif (split[0] == "echo"):
        self.log(split[1])
    elif (split[0] == "clear"):
        consoleText.text = ""

    else:
        self.log(split[0] + " Command Not Found")
    

func log(message):
    print(message)
    consoleText.text = consoleText.text + "\n" + str(message)
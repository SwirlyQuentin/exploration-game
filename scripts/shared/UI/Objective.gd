extends Control
@onready var checked = $Checked
@onready var objName = $Name

var objective = ""

func updateInfo(info):
    objName.text = info
    checked.visible = false
    objective = info

func complete():
    checked.visible = true

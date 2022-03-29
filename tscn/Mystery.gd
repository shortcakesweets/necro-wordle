extends Button

onready var Help_UI = $Help

func _ready():
	Help_UI.visible = false

func _on_Mystery_toggled(button_pressed):
	Help_UI.visible = button_pressed

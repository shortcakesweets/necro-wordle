extends Node2D

onready var Box = $Polygon2D
onready var Number = $Label
onready var tween = $Tween

var palette : Dictionary = {
	"Green" : Color(0,255,0,255),
	"Orange" : Color(255,160,0,255),
	"Grey" : Color(125,125,125,255),
	"White" : Color(255,255,255,255)
}

func _ready():
	set_number(-1)
	set_color("White")

func set_number(target_number : int):
	if target_number < 0:
		Number.text = ""
		return
	
	Number.text = String(target_number)

func set_color(target_color : String):
	Box.color = palette[target_color]

func animate_flip_with_input( target_number : int, target_color : String, tween_duration = 1.0 ):
	tween.stop_all()
	tween.interpolate_property(self, "scale:y", 1, 0, tween_duration/2, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_completed")
	#self.visible
	
	set_number(target_number)
	set_color(target_color)
	
	tween.interpolate_property(self, "scale:y", 0, 1, tween_duration/2, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.start()
	

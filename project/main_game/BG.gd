extends Sprite2D

var bg_list := [
	"res://assets/bg/zone1.jpg", "res://assets/bg/zone2.jpg", "res://assets/bg/zone3.jpg", "res://assets/bg/zone4.jpg", "res://assets/bg/zone5.jpg"
]

func _ready() -> void:
	self.texture = load(bg_list.pick_random())

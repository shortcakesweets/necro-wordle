extends LineEdit

onready var polygon = $Polygon2D
onready var dropdown = $dropdown
var height = [0, 88, 120, 152, 184, 224]

func _ready():
	dropdown.text = ""
	polygon.visible = false

func _on_LineEdit_text_changed(new_text):
	
	if new_text == "":
		_ready()
		return
	
	update_autocomplete(new_text)

func update_autocomplete(new_text):
	var available_names : Array = PriorityData.autocomplete(new_text)
	
	if(available_names.size() >= 5):
		available_names.resize(5)
	
	# Update size of polygon
	resize_polygon( available_names.size() )
	
	# Update the available names
	dropdown.text = ""
	for name_maybe in available_names:
		dropdown.text = dropdown.text + "\n"
		dropdown.text = dropdown.text + name_maybe
		dropdown.text = dropdown.text + "\n"

func resize_polygon(number):
	if number == 0:
		polygon.visible = false
	else:
		polygon.visible = true
	
	polygon.polygon[2] = Vector2(376, height[number])
	polygon.polygon[3] = Vector2(0, height[number])

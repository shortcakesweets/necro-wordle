extends LineEdit

onready var polygon = $Polygon2D
onready var dropdown = $dropdown
var height = [0, 88, 120, 152, 184, 224]
var autocomplete_array = []

func _ready():
	dropdown.text = ""
	polygon.visible = false
	
	#print(polygon.global_position)

func _on_LineEdit_text_changed(new_text):
	
	if new_text == "":
		_ready()
		return
	
	update_autocomplete(new_text)

func update_autocomplete(new_text):
	var available_names : Array = PriorityData.autocomplete(new_text)
	autocomplete_array = available_names.duplicate()
	
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

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() :
		var choice = isInPolygon(event.position)
		if choice != -1:
			self.text = autocomplete_array[choice]
			polygon.visible = false
			dropdown.text = ""
			

func isInPolygon(pos : Vector2):
	if not polygon.visible :
		return -1
	
	var offset : Vector2 = polygon.global_position
	
	# OOB
	if pos.x < offset.x + polygon.polygon[0].x or pos.x > offset.x + polygon.polygon[1].x : # OOB
		return -1
	
	if pos.y < offset.y + polygon.polygon[0].y or pos.y > offset.y + polygon.polygon[3].y : # OOB
		return -1
	
	# what option is clicked?
	var choice : int
	for i in range( height.size() - 1):
		if pos.y - offset.y > height[i] and pos.y - offset.y < height[i+1]:
			choice = i
			print(i)
			break
	
	return choice

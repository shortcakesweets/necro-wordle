extends Node

var raw_data := {}

func _ready() -> void:
	#make_tres()
	pass

func get_filtered_priority() -> void:
	var json = JSON.new()
	var file = FileAccess.open("res://enemy_data/filtered_priority.json", FileAccess.READ)
	
	var error = json.parse(file.get_as_text())
	if error == OK:
		var data_recieved = json.data
		print(data_recieved)

func make_tres() -> void:
	var json = JSON.new()
	var file = FileAccess.open("res://enemy_data/priority.json", FileAccess.READ)
	
	var error = json.parse(file.get_as_text())
	if error == OK:
		var data = json.data as Array[Dictionary]
		for enemy in data:
			if enemy["friendlyName"] == null or enemy["priority"] == null:
				continue
			
			var new_enemy := Enemy.new()
			new_enemy.friendlyName = enemy["friendlyName"]
			new_enemy.name = enemy["name"]
			new_enemy.priority = str(enemy["priority"])
			while new_enemy.priority.length() < 9:
				new_enemy.priority = "0" + new_enemy.priority
			new_enemy.save()

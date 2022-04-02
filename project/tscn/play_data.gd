extends Node

# This script will enable this game to be Daily.

var today_time
var today_inputs = []
var today_hashed_seed = 0

func _ready():
	pass

func _get_seed():
	today_time = OS.get_datetime()
	var today_seed_string = String( today_time["year"] ) + String( today_time["month"] ) + String( today_time["day"] )
	
	return hash( today_seed_string.sha256_text() )

func save_data():
	#print(" save_data occured ")
	
	var save_file = File.new()
	var save_data : Dictionary = {}
	save_data["today_hashed_seed"] = today_hashed_seed
	save_data["today_inputs"] = today_inputs
	
	save_file.open("user://necrodle_save_data.save", File.WRITE)
	save_file.store_line(to_json( save_data ))
	
	#print(save_data)

func get_data():
	var save_file = File.new()
	if not save_file.file_exists("user://necrodle_save_data.save"):
		return false # No such savefile exists. First try
	
	save_file.open("user://necrodle_save_data.save", File.READ)
	var stored_data = parse_json( save_file.get_line() )
	if stored_data["today_hashed_seed"] == today_hashed_seed:
		today_inputs = stored_data["today_inputs"].duplicate(true)
		return stored_data["today_inputs"]
	
	return false 

func make_clipboard():
	pass

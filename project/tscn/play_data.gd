extends Node

# This script will enable this game to be Daily.

var today_inputs = []
var today_hashed_seed = 0

func _ready():
	# _get_seed()
	pass

func _get_seed():
	var today_time = OS.get_datetime()
	var today_seed_string = String( today_time["year"] ) + String( today_time["month"] ) + String( today_time["day"] )
	
	today_hashed_seed = hash(today_seed_string)
	return hash(today_hashed_seed)

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

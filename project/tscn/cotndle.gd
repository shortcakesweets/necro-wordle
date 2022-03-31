extends Node2D 

var rng = RandomNumberGenerator.new()
var answer_index : int
var answer : int
var answer_monsterName : String
var tries : int = 0
export var input_buffer_time = 2.0

onready var Guess1 = $Control/Guesses/Guess1
onready var Guess2 = $Control/Guesses/Guess2
onready var Guess3 = $Control/Guesses/Guess3
onready var Guess4 = $Control/Guesses/Guess4
onready var Guess5 = $Control/Guesses/Guess5
onready var Guess6 = $Control/Guesses/Guess6

onready var cotn_LineEdit = $Control/LineEdit
onready var blinker = $Control/Line2D
onready var system_message = $Control/Label

onready var clipboard_button = $Control/clipboard

onready var help_ui = $Control/help_ui

var guesses : Array = []

func _ready():
	tries = 0
	clipboard_button.disabled = true
	
	guesses.clear()
	guesses.append(Guess1)
	guesses.append(Guess2)
	guesses.append(Guess3)
	guesses.append(Guess4)
	guesses.append(Guess5)
	guesses.append(Guess6)
	
	pick_answer()
	var forcing_data = PlayData.get_data()
	if not forcing_data:
		new_game()
		return
	else:
		if force_entry(forcing_data): # game is still going
			return
		else:
			cotn_LineEdit.editable = false

func pick_answer():
	# The codes that are in comments are used for true RNG
	
	#rng.randomize()
	var size = PriorityData.priority_data.size()
	#answer_index = rng.randi_range(0, size - 1)
	
	# We use daily seed (hashed) to generate today's answer
	answer_index = PlayData._get_seed() % size
	
	answer = int(PriorityData.priority_data[answer_index][0])
	answer_monsterName = PriorityData.priority_data[answer_index][1]
	#print(" picked answer : " + String(answer))
	#print(" with monsterName : " + answer_monsterName)

func _on_LineEdit_text_entered(new_guess_name):
	
	var new_guess = String( PriorityData.get_priority_by_name(new_guess_name) )
	
	if valid_monster(new_guess).size() == 0:
		line_blink()
		print(" Unvalid priority / monster name ")
		return
	
	# Entered some valid monster. Save in local savefile
	PlayData.today_inputs.append(new_guess_name)
	PlayData.save_data()
	
	cotn_LineEdit.editable = false
	cotn_LineEdit.text = ""
	cotn_LineEdit._ready()
	
	if(tries == 5): # erase help_ui
		help_ui.visible = false
	
	guesses[tries].Guess(int(new_guess), answer)
	tries = tries + 1
	
	if( int(new_guess) == int(answer) ): #win
		yield(get_tree().create_timer(input_buffer_time), "timeout")
		game_win()
		guesses[tries-1].set_label( valid_monster(new_guess) )
		return
	
	if(tries >= 6): # game over
		game_over()
		return
	
	yield(get_tree().create_timer(input_buffer_time), "timeout")
	cotn_LineEdit.editable = true
	guesses[tries-1].set_label( valid_monster(new_guess) )

func valid_monster(priority):
	#var priority_int = int(priority)
	
	if PriorityData.only_priority_list.has(int(priority)): # valid
		return PriorityData.get_names_by_priority(priority)
	
	return []

func line_blink(duration = 0.5):
	blinker.visible = true
	yield(get_tree().create_timer(duration), "timeout")
	blinker.visible = false

func _on_Button_pressed():
	new_game()
	for i in range(6):
		guesses[i].reset()

func game_over():
	system_message.text = "Game over! Answer was " + answer_monsterName + "\n with priority " + String(answer)# + "\nPress Reset for a new game."
	cotn_LineEdit.editable = false
	clipboard_button.disabled = false
	lost = true

func game_win():
	system_message.text = "You win! Answer was "+ answer_monsterName # + "\nPress reset for a new game"
	cotn_LineEdit.editable = false
	clipboard_button.disabled = false

func new_game():
	system_message.text = "Can you guess today's monster Priority?"
	pick_answer()
	tries = 0
	help_ui.visible = true
	cotn_LineEdit.editable = true

# returns true when game is still going. false when game was win / lose
func force_entry(today_input):
	print(" force entry occured with data :")
	print(today_input)
	
	if today_input.size() == 0:
		return
	
	cotn_LineEdit.editable = false
	
	for force_guess in today_input:
		var force_guess_int = String( PriorityData.get_priority_by_name(force_guess) )
		guesses[tries].Guess(int(force_guess_int), answer)
		guesses[tries].set_label( valid_monster(force_guess_int) )
		tries = tries + 1
		
		if tries == 6 :
			help_ui.visible = false
		
		if( int(force_guess_int) == int(answer) ): #win
			yield(get_tree().create_timer(input_buffer_time), "timeout")
			game_win()
			guesses[tries-1].set_label( valid_monster(force_guess_int) )
			return false
	
		if(tries >= 6): # game over
			yield(get_tree().create_timer(input_buffer_time), "timeout")
			game_over()
			return false
	
	cotn_LineEdit.editable = true
	return true

# clipboards
const green_box : PoolByteArray = PoolByteArray([237, 160, 189, 237, 191, 169])
const orange_box : PoolByteArray = PoolByteArray([237, 160, 189, 237, 191, 168])
const grey_box : PoolByteArray = PoolByteArray([226, 172, 155])
var lost : bool = false

func _on_clipboard_toggled(button_pressed):
	if button_pressed: # clipboard mode
		system_message.text = ""
		system_message.text += "Daily Necrodle "
		system_message.text += String( PlayData.today_time["year"] ) + "-"
		system_message.text += String( PlayData.today_time["month"] ) + "-"
		system_message.text += String( PlayData.today_time["day"] )
		
		system_message.text += "\n"
		
		if lost:
			system_message.text += "X/6"
		else:
			system_message.text += String(tries) + "/6"
		
		for guess_row in guesses:
			guess_row.hidden_mode()
	
	else : # original mode
		_ready()

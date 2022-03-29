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

onready var help_ui = $Control/help_ui

var guesses : Array = []

func _ready():
	tries = 0
	
	guesses.clear()
	guesses.append(Guess1)
	guesses.append(Guess2)
	guesses.append(Guess3)
	guesses.append(Guess4)
	guesses.append(Guess5)
	guesses.append(Guess6)
	
	new_game()

func pick_answer():
	rng.randomize()
	var size = PriorityData.priority_data.size()
	answer_index = rng.randi_range(0, size - 1)
	
	answer = int(PriorityData.priority_data[answer_index][0])
	answer_monsterName = PriorityData.priority_data[answer_index][1]
	#print(" picked answer : " + String(answer))
	#print(" with monsterName : " + answer_monsterName)

func _on_LineEdit_text_entered(new_guess):
	if valid_monster(new_guess).size() == 0:
		line_blink()
		print(" Unvalid priority. ")
		return
	
	cotn_LineEdit.editable = false
	
	cotn_LineEdit.text = ""
	if(tries == 5): # erase help_ui
		help_ui.visible = false
	
	guesses[tries].Guess(int(new_guess), answer)
	tries = tries + 1
	
	if( int(new_guess) == int(answer) ): #win
		game_win()
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
	system_message.text = "Game over! Answer was " + answer_monsterName + "\n with priority " + String(answer) + "\nPress Reset for a new game."
	cotn_LineEdit.editable = false

func game_win():
	system_message.text = "You win! Answer was "+ answer_monsterName + "\nPress reset for a new game"
	cotn_LineEdit.editable = false

func new_game():
	system_message.text = "Can you guess today's monster Priority?"
	pick_answer()
	tries = 0
	help_ui.visible = true
	cotn_LineEdit.editable = true

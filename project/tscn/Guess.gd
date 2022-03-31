extends Node2D

onready var NumberBox1 = $NumberBox1
onready var NumberBox2 = $NumberBox2
onready var NumberBox3 = $NumberBox3
onready var NumberBox4 = $NumberBox4
onready var NumberBox5 = $NumberBox5
onready var NumberBox6 = $NumberBox6
onready var NumberBox7 = $NumberBox7
onready var NumberBox8 = $NumberBox8

onready var MonsterName = $Label

var NBoxes = []

func _ready():
	NBoxes.clear()
	NBoxes.append(NumberBox1)
	NBoxes.append(NumberBox2)
	NBoxes.append(NumberBox3)
	NBoxes.append(NumberBox4)
	NBoxes.append(NumberBox5)
	NBoxes.append(NumberBox6)
	NBoxes.append(NumberBox7)
	NBoxes.append(NumberBox8)
	
	set_label([])

func Guess(guess : int, answer : int, duration = 1.0):
	
	var guess_str = String(guess)
	var answer_str = String(answer)
	
	var color_sequence : Array = []
	var number_count : Array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	# Set numbercount
	#  - This will count numbers
	for i in range(8):
		number_count[ int(answer_str[i]) ] = number_count[ int(answer_str[i]) ] + 1
	
	# initially all Grey
	for _i in range(8):
		color_sequence.append("Grey")
	
	# Check for Greens
	for i in range(8):
		if( guess_str[i] == answer_str[i] ): # green
			color_sequence[i] = "Green"
			number_count[ int(answer_str[i]) ] = number_count[ int(answer_str[i]) ] - 1
	
	for i in range(8):
		if( color_sequence[i] != "Green" ):
			if( number_count[ int(guess_str[i]) ] > 0 ): #Orange
				color_sequence[i] = "Orange"
				number_count[ int(guess_str[i]) ] = number_count[ int(guess_str[i]) ] - 1 
		
	for i in range(8):
		NBoxes[i].animate_flip_with_input( int(guess_str[i]), color_sequence[i] )
		yield(get_tree().create_timer(duration / 8), "timeout")

func reset():
	for i in range(8):
		NBoxes[i].animate_flip_with_input( -1, "White" )
	set_label([])

func set_label(names : Array):
	if names.size() == 0:
		MonsterName.text = ""
		return
	
	var name_in_one : String = ""
	for mob_name in names:
		name_in_one = name_in_one + mob_name
		if not (names[names.size() - 1] == mob_name):
			name_in_one = name_in_one + "\n"
	
	MonsterName.text = name_in_one

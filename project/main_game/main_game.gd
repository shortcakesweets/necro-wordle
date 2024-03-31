extends Node2D

@export var practice_mode : bool = false
var target : Enemy = null
var guess_list : Array[Enemy] = []
var save_file : DailySave = DailySave.new()
var curr_line : int = 0

@onready var line_list := [
	$Lines/Line0, $Lines/Line2, $Lines/Line3, $Lines/Line4, $Lines/Line5, $Lines/Line6
]

func _ready() -> void:
	if practice_mode:
		target = EnemyList.get_random_enemy()
		$Gamemode.text = "Gamemode\nPractice Mode"
	else:
		save_file = save_file.load()
		target = save_file.target_enemy
		guess_list = save_file.guess_list
		$Gamemode.text = "Gamemode\nDaily Challange"
		for guess in guess_list:
			submit_guess(guess, false)

func submit_guess(guess : Enemy, save : bool = true) -> void:
	line_list[curr_line].animate(guess, evaluate_guess(guess))
	curr_line += 1
	if save:
		guess_list.append(guess)
		if not practice_mode:
			save_file.save_guess_list(guess_list)
	
	if curr_line == 6 or guess.priority == target.priority:
		$Submit.disable_submit()
		var win : bool = guess.priority == target.priority
		$EndPopup.update_message(target, win, practice_mode)

func evaluate_guess(guess : Enemy) -> String:
	var number_count : Array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	var result := "00000000"
	
	for i in range(8):
		number_count[int(target.priority[i+1])] += 1
	
	for i in range(8):
		if target.priority[i+1] == guess.priority[i+1]:
			result[i] = "2"
			number_count[int(guess.priority[i+1])] -= 1
	
	for i in range(8):
		if result[i] != "2" and number_count[int(guess.priority[i+1])] > 0:
			result[i] = "1"
			number_count[int(guess.priority[i+1])] -= 1
	
	return result

func replay_game() -> void:
	if not practice_mode:
		save_file.save()
	SceneTransition.load_maingame(practice_mode, self)

func return_to_lobby() -> void:
	if not practice_mode:
		save_file.save()
	SceneTransition.change_scene("res://lobby.tscn", self)

func screenshot_mode(toggle : bool):
	$EndPopup.visible = not toggle
	for i in range(guess_list.size()):
		var guess : Enemy = guess_list[i]
		line_list[i].animate(guess, evaluate_guess(guess), toggle)

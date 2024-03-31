extends Node2D

signal replay_game
signal return_to_lobby

func update_message(answer : Enemy, win : bool, practice_mode : bool, wait_time : float = 1.0) -> void:
	$Control/EnemyDisplayer.set_guess(answer)
	$Control/Answer.text = "[center]the answer was\n[color=blue]" + answer.friendlyName + "[/color][/center]"
	
	if win:
		$Control/Title.text = "[wave][center]You Win![/center][/wave]"
	else:
		$Control/Title.text = "[wave][center]You Lose...[/center][/wave]"
	
	$Control/Replay.disabled = not practice_mode
	$Control/Return.disabled = false
	
	var timer = get_tree().create_timer(wait_time)
	await timer.timeout
	$Control.visible = true
	$AnimationPlayer.play("appear")

func _on_replay_pressed():
	emit_signal("replay_game")

func _on_return_pressed():
	emit_signal("return_to_lobby")

func _on_texture_button_pressed():
	self.visible = false

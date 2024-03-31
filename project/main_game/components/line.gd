extends Node2D

func animate(guess : Enemy, result : String, screenshot_mode : bool = false, delay : float = 0.1) -> void:
	if screenshot_mode:
		$EnemyDisplayer.set_guess()
	else:
		$EnemyDisplayer.set_guess(guess)
	
	var cell_list = [$Cell0, $Cell1, $Cell2, $Cell3, $Cell4, $Cell5, $Cell6, $Cell7]
	for i in range(8):
		var digit : int = -1
		if not screenshot_mode:
			digit = int(guess.priority[i+1])
		cell_list[i].animate(digit, int(result[i]))
		var timer = get_tree().create_timer(delay)
		await timer.timeout

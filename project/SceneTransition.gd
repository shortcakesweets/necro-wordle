extends CanvasLayer

const main_game := preload("res://main_game/main_game.tscn")

func change_scene(path : String, prev_node) -> void:
	var next_scene = load(path).instantiate()
	
	$AnimationPlayer.play("fade")
	await $AnimationPlayer.animation_finished
	get_tree().root.add_child(next_scene)
	prev_node.queue_free()
	$AnimationPlayer.play_backwards("fade")

func load_maingame(practice_mode : bool, prev_node) -> void:
	var next_scene = main_game.instantiate()
	next_scene.practice_mode = practice_mode
	$AnimationPlayer.play("fade")
	await $AnimationPlayer.animation_finished
	get_tree().root.add_child(next_scene)
	prev_node.queue_free()
	$AnimationPlayer.play_backwards("fade")

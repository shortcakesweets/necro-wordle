extends Node2D

func _on_daily_pressed():
	SceneTransition.load_maingame(false, self)

func _on_practice_pressed():
	SceneTransition.load_maingame(true, self)

func _on_how_to_pressed():
	SceneTransition.change_scene("res://how_to.tscn", self)

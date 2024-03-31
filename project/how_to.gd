extends Node2D

func _on_return_pressed():
	SceneTransition.change_scene("res://lobby.tscn", self)

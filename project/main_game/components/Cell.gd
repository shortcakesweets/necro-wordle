extends Node2D

const palette = [Color.WEB_GRAY, Color.ORANGE, Color.LIME_GREEN]
@onready var anim_player = $AnimationPlayer

func animate(value : int, compare_result : int) -> void:
	anim_player.play("fold")
	await anim_player.animation_finished
	if value != -1:
		$Polygon2D/Label.text = str(value)
	else:
		$Polygon2D/Label.text = ""
	$Polygon2D.color = palette[compare_result]
	anim_player.play_backwards("fold")

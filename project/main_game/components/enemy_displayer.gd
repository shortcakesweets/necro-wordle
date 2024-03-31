extends Node2D

@export var guessed : bool = false
@export var sprite_scale : float = 2.0

func _ready() -> void:
	$AnimatedSprite2D.scale = Vector2.ONE * sprite_scale

func _on_mouse_detect_mouse_entered():
	if guessed:
		%AnimationPlayer.play("appear")

func _on_mouse_detect_mouse_exited():
	if guessed:
		%AnimationPlayer.play_backwards("appear")

func set_guess(guess : Enemy = null) -> void:
	guessed = true
	if guess == null:
		$AnimatedSprite2D.play("None")
		$Label.text = "screenshot mode"
		return
	
	$AnimatedSprite2D.play(guess.name)
	var same_priority_list = EnemyList.enemy_list[guess.priority] as Array[Enemy]
	var text = "same priority as:\n"
	for enemy in same_priority_list:
		text += enemy.friendlyName + "\n"
	$Label.text = text

# function for displaying only enemy and text, mainly in 
func display_anim_and_text(anim_name : String, text : String) -> void:
	$AnimatedSprite2D.play(anim_name)
	$Label.text = text

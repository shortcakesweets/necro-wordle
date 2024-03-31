extends Control

signal submit_guess(enemy : Enemy)

@export var max_candidate_visible := 5
const autocomplete_button := preload("res://main_game/components/texturebutton_blue.tscn")

func _ready() -> void:
	$LineEdit.grab_focus()

func _on_line_edit_text_changed(new_text : String):
	var contain_list : Array[Enemy] = []
	var subsequence_list : Array[Enemy] = []
	
	if new_text != "":
		for enemy in EnemyList.raw_enemy_list:
			var new_text_lc := new_text.to_lower()
			var fName_lc := enemy.friendlyName.to_lower()
			
			if fName_lc.contains(new_text_lc) and not new_text_lc == fName_lc:
				contain_list.append(enemy)
		
		for enemy in EnemyList.raw_enemy_list:
			if enemy in contain_list:
				continue
			
			var new_text_lc := new_text.to_lower()
			var fName_lc := enemy.friendlyName.to_lower()
				
			if new_text_lc.is_subsequence_of(fName_lc) and not new_text_lc == fName_lc:
				subsequence_list.append(enemy)
	
	update_autocomplete(contain_list + subsequence_list)

func update_autocomplete(candidate_list : Array[Enemy]) -> void:
	if candidate_list.size() > max_candidate_visible:
		candidate_list.resize(max_candidate_visible)
	
	_clear_autocomplete()
	
	for enemy in candidate_list:
		var button = Button.new() as Button
		button.text = enemy.friendlyName
		$AutoComplete.add_child(button)
		button.connect("pressed", _on_autocomplete_pressed.bind(enemy))

func _on_autocomplete_pressed(enemy : Enemy) -> void:
	$LineEdit.text = enemy.friendlyName
	_clear_autocomplete()
	$LineEdit.grab_focus()

func _on_line_edit_text_submitted(new_text : String):
	var enemy = EnemyList.get_enemy_by_friendlyName(new_text)
	if enemy != null:
		$LineEdit.text = ""
		emit_signal("submit_guess", enemy)
		_clear_autocomplete()

func disable_submit() -> void:
	$LineEdit.editable = false
	_clear_autocomplete()

func _clear_autocomplete() -> void:
	for child in $AutoComplete.get_children():
		child.queue_free()

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") and not event.is_echo():
		_clear_autocomplete()
		$LineEdit.grab_focus()

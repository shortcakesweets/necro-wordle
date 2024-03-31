extends Node2D

const hint_text0 := "Monster's type\n 1 : Normal \n 2 : Massive \n 3 : Miniboss \n 4 : Boss "
const hint_text1 := "Monster's damage\n ex. Dealing 2.5 hearts \n = 05"
const hint_text2 := "Monster's Health"
const hint_text3 := "Monster's Speed"
const hint_text4 := "Monster's Base Gold"

func _ready() -> void:
	$EnemyDisplayer0.display_anim_and_text("Dragon2", hint_text0)
	$EnemyDisplayer1.display_anim_and_text("Attack", hint_text1)
	$EnemyDisplayer2.display_anim_and_text("Heart", hint_text2)
	$EnemyDisplayer3.display_anim_and_text("Speed", hint_text3)
	$EnemyDisplayer4.display_anim_and_text("GoldPile", hint_text4)

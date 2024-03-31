extends Resource
class_name DailySave

const PATH := "user://dailysave.tres"

@export var target_enemy : Enemy = null
@export var guess_list : Array[Enemy] = []
@export var date : String = ""

func save_guess_list(guess_list_ : Array[Enemy]) -> void:
	guess_list = guess_list_
	save()

func save() -> void:
	ResourceSaver.save(self, PATH)

func load() -> DailySave:
	date = Time.get_date_string_from_system(true)
	if not ResourceLoader.exists(PATH) or ResourceLoader.load(PATH).date != date:
		#print("No savefile detected, or date doesn't match. Creating New savefile")
		target_enemy = EnemyList.get_random_enemy(true, get_seed())
		save()
	else:
		#print("Savefile detected.")
		pass
	return ResourceLoader.load(PATH)

func get_seed() -> int:
	return hash(date.sha256_text())

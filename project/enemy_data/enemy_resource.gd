extends Resource
class_name Enemy

const PATH := "res://enemy_data/enemy_tres/"

@export var friendlyName : String = ""
@export var name : String = ""
@export var priority : String = ""
@export var icon : CompressedTexture2D = null

@export var exclude_from_game : bool = false
@export var synchrony : bool = false
@export var multiplayer_only : bool = false

enum {
	GREY, ORANGE, GREEN
}

func save() -> void:
	ResourceSaver.save(self, PATH + name + ".tres")

func load() -> Resource:
	if not ResourceLoader.exists(PATH):
		save()
	return load(PATH)

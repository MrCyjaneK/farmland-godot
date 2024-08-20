extends Node2D
class_name Level


const TERRAIN_LAYER := 0
const PROPS_LAYER := 1

enum Type {
	WORLD,
	ANIMALS,
	FISHING,
}

## The music to be played during the level.
@export var music: MusicStream

@onready var tiles = $World/Tiles


func _ready() -> void:
	Music.play_music(music)

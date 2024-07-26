extends Node3D


## The music to be played during the level.
@export var bgm: BGM


func _ready() -> void:
	Music.play_music(bgm)

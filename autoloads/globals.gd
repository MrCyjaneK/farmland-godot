extends Node


## Animals found so far.
var animals := 0
## Fishes catch so far.
var fishes := 0
## The time left for fishing.
var time_left := 60

var wallet_scene: String
## Note: fixes the crash after collecting the last animal.
var world = preload("res://levels/world.tscn")


func _enter_tree() -> void:
	if ProjectSettings.get_setting_with_override(&"library/randomize_on_startup"):
		randomize()


func _ready() -> void:
	if ProjectSettings.get_setting_with_override(&"library/double_window_minimum_size"):
		var width = ProjectSettings.get_setting_with_override(&"display/window/size/viewport_width")
		var height = ProjectSettings.get_setting_with_override(&"display/window/size/viewport_height")
		get_window().min_size = Vector2i(width, height) * 2


func reset() -> void:
	animals = 0
	fishes = 0
	time_left = 60

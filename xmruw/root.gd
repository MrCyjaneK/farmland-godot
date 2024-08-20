extends Control


@export var main_scene: PackedScene

## The current wallet screen.
var screen: Node


func _ready() -> void:
	assert(main_scene, "there is no main scene attached")
	Events.wallet_screen_changed.connect(change_screen)
	change_screen(main_scene)


func change_screen(scene: PackedScene) -> void:
	if is_instance_valid(screen):
		screen.queue_free()
	
	screen = scene.instantiate()
	add_child(screen)


func _on_visibility_changed() -> void:
	if is_node_ready():
		get_tree().paused = visible

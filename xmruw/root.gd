extends Control


## The current wallet screen.
var screen: Node


func _ready() -> void:
	Events.wallet_screen_changed.connect(change_screen)


func change_screen(scene: PackedScene) -> void:
	clear()
	%Margin.hide()
	screen = scene.instantiate()
	add_child(screen)


func clear() -> void:
	%Margin.show()
	
	if is_instance_valid(screen):
		screen.queue_free()

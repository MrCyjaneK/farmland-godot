extends CanvasLayer
class_name UI


## A reusable UI system.

@export var pause_action := &"ui_cancel"
@export var console_action := &"console"

## A reference to the active console.
var console: ConsoleContainer


func _ready() -> void:
	Events.ui_updated.connect(_update)
	Events.game_over.connect(_game_over)
	
	_update()


## Handles the logic when the UI is updated. Override to provide custom behavior.
func _update() -> void:
	pass


func _input(event: InputEvent) -> void:
	if pause_action and event.is_action_pressed(pause_action):
		get_viewport().set_input_as_handled()
		add_child(preload("res://ui/pause.tscn").instantiate())
	elif console_action and event.is_action_pressed(console_action):
		get_viewport().set_input_as_handled()
		
		if is_instance_valid(console):
			console.queue_free()
			%ConsoleWrapper.hide()
		else:
			console = ConsoleContainer.new()
			%ConsoleWrapper.add_child(console)
			%ConsoleWrapper.show()


func _game_over() -> void:
	add_child(preload("res://ui/game_over.tscn").instantiate())

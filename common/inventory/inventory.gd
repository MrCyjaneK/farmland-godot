extends Control
class_name Inventory


## A reusable pause screen.

@export var inventory_action := &"inventory"
@export var close_action := &"ui_cancel"


func _ready() -> void:
	if not (inventory_action and InputMap.has_action(inventory_action)):
		push_warning("there is no input action \"%s\" configured" % inventory_action)
	
	if not (close_action and InputMap.has_action(close_action)):
		push_warning("there is no input action \"%s\" configured" % close_action)
	
	_handle_pause(true)
	Events.game_paused.emit()


func _exit_tree() -> void:
	_handle_pause(false)


## Handles the pause logic. Override to provide custom behavior.
func _handle_pause(paused: bool) -> void:
	get_tree().paused = paused


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(inventory_action) or event.is_action_pressed(close_action):
		get_viewport().set_input_as_handled()
		queue_free()


## Handles the close logic. Override to provide custom behavior.
func _close() -> void:
	queue_free()

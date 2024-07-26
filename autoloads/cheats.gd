extends Node


## A reusable cheat system.


## A cheat registry that maps input action names to functions that should be called.
var cheat_registry := {}


func _ready() -> void:
	set_process(ProjectSettings.get_setting_with_override(&"library/cheats") and OS.is_debug_build())


## Registers a cheat to be activated when the given input action is held down.
func add_cheat(input_action: StringName, callable: Callable) -> void:
	assert(InputMap.has_action(input_action), "there is no input action registered for %s" % input_action)
	assert(not cheat_registry.has(input_action), "there is a cheat already registered for %s" % input_action)
	cheat_registry[input_action] = callable


## Removes the cheat associated with the given input action.
func remove_cheat(input_action: StringName) -> void:
	assert(cheat_registry.has(input_action), "there is no cheat registered for %s" % input_action)
	cheat_registry.erase(input_action)


func _process(_delta: float) -> void:
	for action in cheat_registry:
		if Input.is_action_pressed(action):
			cheat_registry[action].call()

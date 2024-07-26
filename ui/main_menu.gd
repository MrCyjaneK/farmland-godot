extends Control


## A reusable main menu UI.

## Display the project name in the game title field.
@export var use_project_name := true
## The parent node to spawn dynamic nodes.
@export var root: Node
## A sound to be played once.
@export var sound: AudioStream
## The volume to play the sound.
@export_range(0.0, 2.0, 0.01) var sound_volume := 1.0
## The bus to play the sound.
@export var sound_bus := &"Sounds"
## The music to be played in the main menu.
@export var bgm: BGM
## The control to be focused.
@export var focus_control: Control


func _ready() -> void:
	AudioManager.play(sound, sound_volume, sound_bus)
	Music.play_music(bgm)
	
	if use_project_name:
		var project_name: String = ProjectSettings.get_setting_with_override(&"application/config/name")
		
		if project_name:
			%Title.text = project_name
		else:
			push_error("The project doesn't have a valid name.")
	
	if is_instance_valid(focus_control):
		focus_control.grab_focus()


## Handles the logic when the new game button is pressed. Override to provide custom behavior.
func _new_game() -> void:
	push_warning("New game logic not implemented!")


## Handles the logic when the load game button is pressed. Override to provide custom behavior.
func _load_game() -> void:
	Globals.load_game()


## Handles the logic when the how to play button is pressed. Override to provide custom behavior.
func _how_to_play() -> void:
	root.add_child(preload("res://ui/how_to_play.tscn").instantiate())


## Handles the logic when the options button is pressed. Override to provide custom behavior.
func _options() -> void:
	%Margin.hide()
	var options = preload("res://ui/options.tscn").instantiate()
	options.tree_exited.connect(%Margin.show)
	options.tree_exited.connect(%Options.grab_focus)
	root.add_child(options)


## Handles the logic when the quit button is pressed. Override to provide custom behavior.
func _quit() -> void:
	root.add_child(preload("res://ui/quit_confirmation.tscn").instantiate())

extends Node


## The default path for the settings file.
const SETTINGS_PATH := "user://settings.dat"
## The default path for the save file.
const SAVE_PATH := "user://save.dat"
## The version of the same file. (for backward compatibility)
const SAVE_VERSION := 1


func _enter_tree() -> void:
	if ProjectSettings.get_setting_with_override(&"library/randomize_on_startup"):
		randomize()
	
	load_settings(SETTINGS_PATH)


func _ready() -> void:
	if ProjectSettings.get_setting_with_override(&"library/double_window_minimum_size"):
		var width = ProjectSettings.get_setting_with_override(&"display/window/size/viewport_width")
		var height = ProjectSettings.get_setting_with_override(&"display/window/size/viewport_height")
		get_window().min_size = Vector2i(width, height) * 2


## Saves the game state to the given file path.
func save_game(file_path := SAVE_PATH) -> void:
	var f = FileAccess.open(file_path, FileAccess.WRITE)
	var err = f.get_error()
	
	if err == OK:
		f.store_var(SAVE_VERSION)
		var scene_path = get_tree().current_scene.scene_file_path
		assert(scene_path, "Current scene path is empty")
		f.store_var(scene_path)
		
		push_warning("Save game logic not implemented!")
	else:
		push_error("Failed to save file %s (error %d)." % [file_path, err])


## Loads the game state from the given file path.
func load_game(file_path := SAVE_PATH) -> void:
	if FileAccess.file_exists(file_path):
		var f = FileAccess.open(file_path, FileAccess.READ)
		var err = f.get_error()
		
		if err == OK:
			var version = f.get_var()
			assert(typeof(version) == TYPE_INT, "Failed to load save file version (%s)" % file_path)
			var scene_path = f.get_var()
			assert(typeof(scene_path) == TYPE_STRING, "Failed to load scene from save file (%s)" % file_path)
			
			push_warning("Load game logic not implemented!")
			
			get_tree().change_scene_to_file(scene_path)
		else:
			push_error("Failed to save file %s (error %d)." % [file_path, err])


## Saves the game settings.
func save_settings(filename: String) -> void:
	var f = FileAccess.open(filename, FileAccess.WRITE)
	var err = f.get_error()
	
	if err == OK:
		# Save window fullscreen mode
		f.store_var(get_window().mode == Window.MODE_FULLSCREEN)
		
		# Save audio buses volumes
		var buses = []
		
		for bus in AudioServer.bus_count:
			buses.append(AudioServer.get_bus_volume_db(bus))
		
		f.store_var(buses)
	else:
		push_error("Failed to save file to %s (error %d)" % [filename, err])


## Loads the game settings.
func load_settings(filename: String) -> void:
	if FileAccess.file_exists(SETTINGS_PATH):
		var f = FileAccess.open(filename, FileAccess.READ)
		var err = f.get_error()
		
		if err == OK:
			# Read window fullscreen mode
			get_window().mode = Window.MODE_FULLSCREEN if f.get_var() else Window.MODE_WINDOWED
			
			# Read audio buses volumes
			var bus = 0
			
			for volume in f.get_var():
				AudioServer.set_bus_volume_db(bus, volume)
				bus += 1
		else:
			push_error("Failed to load file from %s (error %d)" % [filename, err])

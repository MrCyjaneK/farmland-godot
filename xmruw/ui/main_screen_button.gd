extends Button


@export_file("*.tscn") var scene := ""


func _ready() -> void:
	assert(ResourceLoader.exists(scene), "scene from path %s doesn't exist" % scene)
	
	if not button_pressed:
		text = ""


func _pressed() -> void:
	if Globals.wallet_scene != scene:
		Events.wallet_screen_changed.emit(load(scene))
		Globals.wallet_scene = scene
	else:
		button_pressed = true

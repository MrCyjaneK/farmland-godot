extends Area2D


@export_flags("Areas", "Bodies") var types := 2
@export_file("*.tscn") var scene_path := ""

var _cached_scene: PackedScene


func _ready() -> void:
	assert(ResourceLoader.exists(scene_path), "scene path doesn't point to a valid scene")
	_cached_scene = load(scene_path)
	
	if types & 0x1:
		area_entered.connect(_teleport, CONNECT_DEFERRED)
	
	if types & 0x2:
		body_entered.connect(_teleport, CONNECT_DEFERRED)


func _teleport(player: Node2D) -> void:
	if not Globals.exiting_level:
		Globals.player_position = player.position
		get_tree().change_scene_to_packed(_cached_scene)

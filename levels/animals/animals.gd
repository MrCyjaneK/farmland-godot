extends Level


@export_range(1, 999, 1) var animal_count := 5


func _ready() -> void:
	Events.ui_updated.connect(_ui_updated)
	super()
	
	# Spawn animals and keep track of spawn points used
	var nodes = []
	
	for i in animal_count:
		var spawn_points = get_tree().get_nodes_in_group(&"spawn_points")
		
		if spawn_points:
			var spawn_point = spawn_points.pick_random()
			spawn_point.remove_from_group(&"spawn_points")
			nodes.append(spawn_point)
			
			var animal = preload("res://animals/animal.tscn").instantiate()
			world.add_child(animal)
			animal.set_block_signals(true)
			animal.global_position = spawn_point.global_position
			animal.set_block_signals(false)
		else:
			# Stop when run out of spawn points
			break
	
	# Add spawn points back to group for use later
	for node: Node in nodes:
		node.add_to_group(&"spawn_points")
	
	Events.ui_updated.emit()


func _ui_updated() -> void:
	if Globals.animals >= animal_count:
		Globals.reset()
		Globals.exiting_level = true
		get_tree().change_scene_to_packed.call_deferred(Globals.world)

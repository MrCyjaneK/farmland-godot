extends Node2D


func _process(_delta: float) -> void:
	var cam_pos = (get_viewport().get_camera_2d()
			.get_screen_center_position())
	var x = cam_pos.x
	var y = cam_pos.y
	
	var bounds = Rect2(x - 320, y - 180, 640, 360)
	visible = not bounds.has_point(owner.global_position)
	
	position = (owner.global_position.clamp(bounds.position, bounds.end))
	rotation = (cam_pos
			.direction_to(owner.global_position).angle())

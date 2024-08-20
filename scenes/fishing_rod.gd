extends Node2D


const LENGTH := 16

@onready var pivot = $Pivot


func _process(_delta: float) -> void:
	queue_redraw()


func _draw() -> void:
	var pod_origin = Vector2(0.0, -LENGTH)
	draw_line(Vector2(), pod_origin, Color.DARK_GRAY)
	draw_line(pod_origin, pivot.position, Color.WHITE)

extends Camera2D


@export var reset_smoothing_on_ready := true


func _ready() -> void:
	if reset_smoothing_on_ready:
		reset_smoothing()

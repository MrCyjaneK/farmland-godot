extends Control


func _process(delta: float) -> void:
	%Icon.pivot_offset = %Icon.get_rect().size / 2.0
	%Icon.rotation -= TAU * delta

extends Button


@export var scene: PackedScene


func _pressed() -> void:
	Events.wallet_screen_changed.emit(scene)

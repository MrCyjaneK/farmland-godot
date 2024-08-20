extends Area2D


@onready var sprite = $Sprite


func _ready() -> void:
	sprite.texture = [
		preload("res://assets/sprites/animals/chicken.png"),
		preload("res://assets/sprites/animals/cow.png"),
		preload("res://assets/sprites/animals/pig.png"),
		preload("res://assets/sprites/animals/sheep.png"),
	].pick_random()
	sprite.flip_h = randf() < 0.5
	Events.ui_updated.emit()


func _exit_tree() -> void:
	Events.ui_updated.emit()


func _on_body_entered(_body: Node2D) -> void:
	Globals.animals += 1
	AudioManager.play(preload("res://assets/sounds/pickup_1.wav"), 1.0, &"Sounds")
	queue_free()

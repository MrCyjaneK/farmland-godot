extends Node


## A reusable velocity node to be used as child of a Node2D.

## The direction at which the root node will be moved.
@export var direction := Vector2.RIGHT
## How fast the root node will be moved.
@export_range(1, 10_000, 1, "suffix:px/s") var speed := 128
## The root node to be moved.
@export var root: Node2D


func _physics_process(delta: float) -> void:
	root.translate(direction * speed * delta)

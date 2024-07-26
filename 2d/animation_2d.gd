extends Node
class_name Animation2D


@export var targets: Array[Node2D]
@export_range(0.01, 10000.0, 0.001, "suffix:units/s") var speed := 1.0
@export_range(0.01, 10000.0, 0.001, "suffix:s") var rollout := TAU

var counter := 0.0


func _process(delta: float) -> void:
	for target in targets:
		_animate(target, counter)
	
	counter = wrapf(counter + speed * delta, 0.0, rollout)


func _animate(node: Node2D, counter: float) -> void:
	pass

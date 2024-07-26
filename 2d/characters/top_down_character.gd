extends CharacterBody2D
class_name TopDownCharacter


## A reusable top-down character.


## How fast the character will move around.
@export_range(1, 10000, 1, "suffix:px/s") var movement_speed := 128

## The direction the character is moving to.
var direction := Vector2()
## The direction the character is facing to.
var facing := Vector2.DOWN


func _physics_process(delta: float) -> void:
	# Process character movement
	velocity = direction * movement_speed
	
	# Set facing direction
	if direction:
		facing = direction
	
	# Perform the actual movement
	move_and_slide()

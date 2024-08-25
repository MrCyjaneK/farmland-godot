extends Character
class_name Player


@onready var boat: Sprite2D = $Sprite/Boat
@onready var water: Area2D = $Water


func _physics_process(delta: float) -> void:
	# Get input
	direction = Input.get_vector(&"left", &"right", &"up", &"down")
	
	# Process character movement
	super(delta)
	
	boat.visible = water.has_overlapping_bodies()

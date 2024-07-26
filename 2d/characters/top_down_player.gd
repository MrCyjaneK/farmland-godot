extends TopDownCharacter
class_name TopDownPlayer


func _physics_process(delta: float) -> void:
	# Get input
	direction = Input.get_vector(&"left", &"right", &"up", &"down")
	
	# Process character movement
	super(delta)

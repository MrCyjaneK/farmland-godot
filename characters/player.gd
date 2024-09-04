extends Character
class_name Player


@onready var boat: Sprite2D = $Sprite/Boat
@onready var water: Area2D = $Water


func _ready() -> void:
	if Globals.exiting_level:
		position = Globals.player_position


func _physics_process(delta: float) -> void:
	# Get input
	direction = Input.get_vector(&"left", &"right", &"up", &"down")
	
	# Process character movement
	super(delta)
	
	boat.visible = water.has_overlapping_bodies()

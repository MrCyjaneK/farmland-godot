extends ParallaxBackground


@export var noise: FastNoiseLite

@onready var clouds = $Clouds


func _ready() -> void:
	noise.seed = randi()


func _process(delta: float) -> void:
	clouds.motion_offset.x -= 16.0 * delta

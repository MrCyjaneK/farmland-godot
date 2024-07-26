extends Control


@export var text := ""
@export_range(0.001, 1.0, 0.001, "suffix:s") var letter_speed := 0.012
@export_range(0.01, 10.0, 0.01, "suffix:s") var time_left := 2.0
@export var destroy := true

var _letter_speed := letter_speed
var _time_left := time_left


func _ready() -> void:
	assert(text, "the text field is empty")
	%Text.text = text


func _process(delta: float) -> void:
	if %Text.visible_characters < text.length():
		if _letter_speed > 0.0:
			_letter_speed -= delta
		else:
			_letter_speed = letter_speed
			%Text.visible_characters += 1
	elif _time_left > 0.0:
		_time_left -= delta
	elif destroy:
		queue_free()
	else:
		set_process(false)

extends CanvasLayer
class_name UI


## A reusable UI system.

@export var pause_action := &"ui_cancel"
@export var console_action := &"console"
@export var level_type := Level.Type.WORLD

var animal_count := 0
var fish_count := 0

@onready var virtual_joystick = $VirtualJoystick
@onready var fishing_timer = $FishingTimer


func _ready() -> void:
	Events.ui_updated.connect(_update)
	
	if not OS.has_feature(&"mobile"):
		virtual_joystick.queue_free()
	
	await get_tree().process_frame
	animal_count = get_tree().get_nodes_in_group(&"animals").size()
	fish_count = get_tree().get_nodes_in_group(&"fishes").size()
	
	if level_type == Level.Type.FISHING:
		fishing_timer.start()
	
	_update()
	Globals.exiting_level = false


## Handles the logic when the UI is updated. Override to provide custom behavior.
func _update() -> void:
	%Animals.visible = level_type == Level.Type.ANIMALS
	%Animals.text = "Animals: %d/%d" % [Globals.animals, animal_count]
	%TimeLeft.visible = level_type == Level.Type.FISHING
	%TimeLeft.text = "Time Left: %02d:%02d" % [int(Globals.time_left / 60.0), Globals.time_left % 60]
	%Fishes.visible = level_type == Level.Type.FISHING
	%Fishes.text = "Fishes: %d/%d" % [Globals.fishes, fish_count]
	%FishMargin.visible = level_type == Level.Type.FISHING
	%Device.visible = level_type == Level.Type.WORLD
	%Leave.visible = level_type != Level.Type.WORLD
	
	if is_instance_valid(virtual_joystick):
		virtual_joystick.visible = level_type != Level.Type.FISHING


func fish() -> void:
	AudioManager.play(preload("res://assets/sounds/hit_4.wav"), 1.0, &"Sounds")
	
	if randi() % 10 == 0:
		Globals.fishes += 1
		AudioManager.play(preload("res://assets/sounds/pickup_1.wav"), 1.0, &"Sounds")
		Events.ui_updated.emit()
	
	if Globals.fishes >= fish_count:
		Globals.reset()
		leave()


func tick_fishing() -> void:
	Globals.time_left -= 1
	Events.ui_updated.emit()
	
	if Globals.time_left <= 0:
		Globals.reset()
		leave()


func toggle_device() -> void:
	%Root.visible = not %Root.visible
	
	if not %Root.visible:
		%Root.clear()


func leave() -> void:
	Globals.exiting_level = true
	get_tree().change_scene_to_packed(Globals.world)

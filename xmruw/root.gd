extends Control


enum WalletTheme {
	XMRUW,
	CAKE,
}

## The wallet theme to be used.
@export var wallet_theme := WalletTheme.XMRUW

## The current wallet screen.
var screen: Node


func _ready() -> void:
	Events.wallet_screen_changed.connect(change_screen)
	
	# Load main scene based on wallet theme
	var main_scene = (preload("res://xmruw/xmruw/screens/unlock_screen.tscn")
			if wallet_theme == WalletTheme.XMRUW else
			preload("res://xmruw/cake/screens/unlock_screen.tscn"))
	
	change_screen(main_scene)


func change_screen(scene: PackedScene) -> void:
	if is_instance_valid(screen):
		screen.queue_free()
	
	screen = scene.instantiate()
	add_child(screen)

extends Control


func fee() -> void:
	# Do what you want to do when pressing the "fee" button
	pass


func _continue() -> void:
	# Ask to continue
	add_child(preload("res://xmruw/cake/confirmation.tscn").instantiate())

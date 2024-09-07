extends Control


func _ready() -> void:
	%QRCodeRect.data = %Address.text


func copy_address() -> void:
	DisplayServer.clipboard_set(Monero.getAddress(0, 0))

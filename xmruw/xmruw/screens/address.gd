extends Label


func _ready():
	%Address.text = Monero.getAddress(0, 0)

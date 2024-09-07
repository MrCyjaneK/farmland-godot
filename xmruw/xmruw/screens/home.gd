extends Control


@onready var popup: PopupMenu = %More.get_popup()


func _ready() -> void:
	popup.index_pressed.connect(_index_pressed)
	
	# Load transactions example:
	for i in Monero.getTransactionCount():
		var direction = Monero.getTransactionDirection(i);
		var amount = "%.12f" % (Monero.getTransactionAmount(i)/1e12) + " XMR";
		var timestamp = Monero.getTransactionTimestamp(i)
		var transaction = Label.new()
		transaction.text = "d:" + str(direction) + " a: " + amount + " t: " + str(timestamp)
		%Transactions.add_child(transaction)


func code() -> void:
	# Do what you want when the code button is pressed.
	pass


func _index_pressed(index: int) -> void:
	if index == 0:
		add_child(preload("res://xmruw/xmruw/loading_screen.tscn").instantiate())
		# Save and exit logic here

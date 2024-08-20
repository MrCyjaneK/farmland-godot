extends Label


func _ready():
	%Balance.text = "%.12f" % (Monero.getBalance(0)/1e12) + " XMR"


func round_place(num, places):
	return (round(num*pow(10,places))/pow(10,places))

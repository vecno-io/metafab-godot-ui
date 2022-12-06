extends Container

onready var _name = get_node("%NameLabel")
onready var _balance = get_node("%BalanceField")

func set_info(name: String, value: String):
	_name = get_node("%NameLabel")
	_name.text = name
	_balance = get_node("%BalanceField")
	_balance.text = value

extends Container

onready var txn_id_field = get_node("%TxnIdField")
onready var txn_hash_field = get_node("%TxnHashField")

onready var error_box_txn = get_node("%ErrorBoxTxn")
onready var result_box_txn = get_node("%ResultBoxTxn")

func clear():
	error_box_txn.hide()
	error_box_txn.clear()
	result_box_txn.visible = false
	txn_id_field.text = ""
	txn_hash_field.text = ""

func show_data(data: Dictionary):
	error_box_txn.hide()
	result_box_txn.visible = true
	if !data.has("id"): txn_id_field.text = ""
	else: txn_id_field.text = data["id"]
	if !data.has("hash"): txn_hash_field.text = ""
	else: txn_hash_field.text = data["hash"]

func show_error(name: String, code: int, message: String):
	result_box_txn.visible = false
	error_box_txn.show_error(name, code, message)
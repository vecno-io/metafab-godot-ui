extends Container


onready var bal_list = get_node("%BalanceList")
onready var bal_error_box = get_node("%BalErrorBox")
onready var bal_result_box = get_node("%BalResultBox")

onready var txn_list = get_node("%TransactionList")
onready var txn_error_box = get_node("%TxnErrorBox")
onready var txn_result_box = get_node("%TxnResultBox")

onready var walletid_input = get_node("%WalletIdInput")
onready var submit_button = get_node("%SubmitButton")

var BalanceItem = preload("res://demo/wallets/BalanceItem.tscn")
var TransactionItem = preload("res://demo/wallets/TransactionItem.tscn")

func _ready():
	submit_button.connect("pressed", self, "_on_submit_pressed")


func _on_submit_pressed():
	print("[%s] _on_submit_pressed: %s" % [name, walletid_input.text])
	var res = MetaFab.get_wallet_balances(self, "_on_bal_request_result", walletid_input.text)
	if res == MetaFabRequest.Ok: self._clear_bal()
	else: self._show_bal_error.show_data(-1, name, res)	
	var ress = MetaFab.get_wallet_transactions(self, "_on_txn_request_result", walletid_input.text)
	if ress == MetaFabRequest.Ok: self._clear_txn()
	else: self._show_txn_error.show_data(-1, name, ress)


func _on_bal_request_result(code: int, result: String):
	var json = JSON.parse(result)
	if code == 200: self._show_bal_data(json.result)
	else: self._show_bal_error(code, json.result)

func _on_txn_request_result(code: int, result: String):
	var json = JSON.parse(result)
	if code == 200: self._show_txn_data(json.result)
	else: self._show_txn_error(code, json.result)


func _clear_bal():
	bal_error_box.hide()
	bal_error_box.clear()
	bal_result_box.visible = false
	for node in bal_list.get_children():
		node.queue_free()

func _show_bal_data(data: Dictionary):
	bal_error_box.hide()
	bal_result_box.visible = true
	for key in data: 
		var item = BalanceItem.instance()
		item.set_info(key.capitalize(), data[key])
		bal_list.add_child(item)
		

func _show_bal_error(code: int, message: String):
	bal_result_box.visible = false
	bal_error_box.show_error("%s/Balance" % name, code, message)


func _clear_txn():
	txn_error_box.hide()
	txn_error_box.clear()
	txn_result_box.visible = false
	for node in txn_list.get_children():
		node.queue_free()

func _show_txn_data(data: Array):
	if data.empty():
		self._show_txn_error(0, "no transaction found")
		return
	txn_error_box.hide()
	txn_result_box.visible = true
	for txn in data:
		print_debug(txn)
		var item = TransactionItem.instance()
		txn_list.add_child(item)
		item.set_info(txn)

func _show_txn_error(code: int, message: String):
	txn_result_box.visible = false
	txn_error_box.show_error("%s/Transaction" % name, code, message)

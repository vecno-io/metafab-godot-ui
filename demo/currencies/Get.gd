extends HBoxContainer

onready var txn_info = get_node("%TxnInfo")

onready var error_box = get_node("%ErrorBox")
onready var result_box = get_node("%ResultBox")
onready var result_list = get_node("%ResultList")

onready var publickey_input = get_node("%PublicKeyInput")
onready var currency_button = get_node("%CurrencyButton")

onready var error_box_balance = get_node("%ErrorBoxBalance")
onready var result_box_balance = get_node("%ResultBoxBalance")

onready var wallet_input = get_node("%WalletInput")
onready var currency_input = get_node("%CurrencyInput")
onready var balance_button = get_node("%BalanceButton")

onready var name_field = get_node("%NameField")
onready var symbol_field = get_node("%SymbolField")
onready var balance_field = get_node("%BalanceField")

onready var amount_input = get_node("%AmountInput")
onready var secretkey_input = get_node("%SecretKeyInput")
onready var password_input = get_node("%PasswordInput")
onready var mint_button = get_node("%MintButton")

onready var burn_amount_input = get_node("%BurnAmountInput")
onready var burn_key_input = get_node("%BurnKeyInput")
onready var burn_password_input = get_node("%BurnPasswordInput")
onready var burn_button = get_node("%BurnButton")

var CurrencyItem = preload("res://demo/currencies/CurrencyItem.tscn")

func _ready():
	burn_button.connect("pressed", self, "_on_burn_currency_pressed")
	mint_button.connect("pressed", self, "_on_mint_currency_pressed")
	balance_button.connect("pressed", self, "_on_get_balance_pressed")
	currency_button.connect("pressed", self, "_on_get_currencies_pressed")


func _on_burn_currency_pressed():
	print("[%s] _on_burn_currency_pressed: %s" % [name, wallet_input.text])
	var res = MetaFab.burn_currency(self, "_on_burn_currency_result", currency_input.text,
		burn_amount_input.text.to_float(), burn_key_input.text, burn_password_input.text
	)
	if res == MetaFabRequest.Ok: 
		txn_info.clear()
		self._clear_balance()
	else: 
		txn_info.show_error(-1, name, res)

func _on_burn_currency_result(code: int, result: String):
	var json = JSON.parse(result)
	if code == 200: 
		self._on_get_balance_pressed()
		txn_info.show_data(json.result)
	else:
		txn_info.show_error(code, result)


func _on_mint_currency_pressed():
	print("[%s] _on_mint_currency_pressed: %s" % [name, wallet_input.text])
	var res = MetaFab.mint_currency(self, "_on_mint_currency_result", 
		currency_input.text, wallet_input.text, amount_input.text.to_float(),
		secretkey_input.text, password_input.text, true
	)
	if res == MetaFabRequest.Ok: 
		txn_info.clear()
		self._clear_balance()
	else: 
		txn_info.show_error(-1, name, res)

func _on_mint_currency_result(code: int, result: String):
	var json = JSON.parse(result)
	if code == 200: 
		self._on_get_balance_pressed()
		txn_info.show_data(json.result)
	else: 
		txn_info.show_error(code, result)


func _on_get_balance_pressed():
	print("[%s] _on_get_balance_pressed: %s" % [name, wallet_input.text])
	var res = MetaFab.get_currency_balance(self, "_on_get_balance_result", currency_input.text, wallet_input.text)
	if res == MetaFabRequest.Ok: self._clear_balance()
	else: error_box_balance.show_data(-1, name, res)

func _on_get_balance_result(code: int, result: String):
	var json = JSON.parse(result)
	if code == 200: self._show_balance_data(json.result)
	else: self._show_balance_error(code, json.result)


func _on_get_currencies_pressed():
	print("[%s] _on_get_currencies_pressed: %s" % [name, publickey_input.text])
	var res = MetaFab.get_currencies(self, "_on_get_currencies_result", publickey_input.text)
	if res == MetaFabRequest.Ok: self._clear_list_currency()
	else: error_box.show_error(name, -1, res)

func _on_get_currencies_result(code: int, result: String):
	var json = JSON.parse(result)
	if code == 200: self._show_currency_list(json.result)
	else: self._show_currency_error(code, result)


func _clear_balance():
	error_box_balance.hide()
	error_box_balance.clear()
	result_box_balance.visible = false
	balance_field.text = ""

func _show_balance_data(value: String):
	error_box_balance.hide()
	balance_field.text = value
	result_box_balance.visible = true

func _show_balance_error(code: int, message: String):
	result_box_balance.visible = false
	error_box_balance.show_error(name, code, message)


func _clear_list_currency():
	error_box.hide()
	error_box.clear()
	result_box.visible = false
	for item in result_list.get_children():
		item.queue_free()

func _show_currency_list(array: Array):
	error_box.hide()
	for data in array:
		var item = CurrencyItem.instance()
		item.connect("select", self, "_on_select_currency")
		result_list.add_child(item)
		item.set_info(data)
	result_box.visible = true

func _show_currency_error(code: int, message: String):
	result_box.visible = false
	error_box.show_error(name, code, message)

func _on_select_currency(data: Dictionary):
	if !data.has("name"): name_field.text = ""
	else: name_field.text = data["name"]
	if !data.has("symbol"): symbol_field.text = ""
	else: symbol_field.text = data["symbol"]
	if !data.has("id"): currency_input.text = ""
	else: currency_input.text = data["id"]

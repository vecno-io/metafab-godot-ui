extends Container

onready var error_box = get_node("%ErrorBox")
onready var result_box = get_node("%ResultBox")

onready var chain_select = get_node("%ChainSelect")
onready var name_input = get_node("%NameInput")
onready var symbol_input = get_node("%SymbolInput")
onready var supplycap_input = get_node("%SupplyCapInput")
onready var secretkey_input = get_node("%SecretKeyInput")
onready var password_input = get_node("%PasswordInput")
onready var submit_button = get_node("%SubmitButton")

onready var name_field = get_node("%NameField")
onready var symbol_field = get_node("%SymbolField")
onready var supplycap_field = get_node("%MaxSupplyField")
onready var contractid_field = get_node("%ContractIdField")
onready var currencyid_field = get_node("%CurrencyIdField")

func _ready():
	submit_button.connect("pressed", self, "_on_submit_pressed")


func _on_submit_pressed():
	print("[%s] _on_submit_pressed: %s" % [name, name_input.text])
	var res = MetaFab.create_currency(
		self, "_on_request_result", 
		chain_select.chain, name_input.text, symbol_input.text, 
		supplycap_input.text, secretkey_input.text, password_input.text
	)
	if res == MetaFabRequest.Ok: self._clear()
	else: self._show_error(-1, res)

func _on_request_result(code: int, result: String):
	var json = JSON.parse(result)
	if code == 200: self._show_data(json.result)
	else: self._show_error(code, json.result)


func _clear():
	error_box.hide()
	error_box.clear()
	result_box.visible = false
	name_field.text = ""
	symbol_field.text = ""
	supplycap_field.text = ""
	contractid_field.text = ""
	currencyid_field.text = ""

func _show_data(data: Dictionary):
	error_box.hide()
	result_box.visible = true
	if !data.has("name"): name_field.text = ""
	else: name_field.text = data["name"]
	if !data.has("symbol"): symbol_field.text = ""
	else: symbol_field.text = data["symbol"]
	if !data.has("supplyCap"): supplycap_field.text = ""
	else: supplycap_field.text = "%s" % data["supplyCap"]
	if !data.has("contractId"): contractid_field.text = ""
	else: contractid_field.text = data["contractId"]
	if !data.has("id"): currencyid_field.text = ""
	else: currencyid_field.text = data["id"]

func _show_error(code: int, message: String):
	result_box.visible = false
	error_box.show_error(name, code, message)

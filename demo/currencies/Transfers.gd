extends Container

onready var txn_info = get_node("%TxnInfo")

onready var token_input = get_node("%TokenInput")
onready var password_input = get_node("%PasswordInput")
onready var currency_input = get_node("%CurrencyInput")

onready var wallet_input_a = get_node("%WalletInputV1")
onready var amount_input_a = get_node("%AmountInputV1")
onready var reference_input_a = get_node("%ReferenceInputV1")

onready var wallet_input_b = get_node("%WalletInputV2")
onready var amount_input_b = get_node("%AmountInputV2")
onready var reference_input_b = get_node("%ReferenceInputV2")

onready var wallet_input_c = get_node("%WalletInputV3")
onready var amount_input_c = get_node("%AmountInputV3")
onready var reference_input_c = get_node("%ReferenceInputV3")

onready var batch_button = get_node("%BatchButton")
onready var transfer_button = get_node("%TransferButton")

func _ready():
	batch_button.connect("pressed", self, "_on_batch_pressed")
	transfer_button.connect("pressed", self, "_on_transfer_pressed")


func _on_batch_pressed():
	print("[%s] _on_batch_pressed: %s" % [name, currency_input.text])
	var amounts = []
	var wallets = []
	var references = []
	if !wallet_input_a.text.empty():
		wallets.append(wallet_input_a.text)
		amounts.append(amount_input_a.text.to_float())
		references.append(reference_input_a.text.to_int())
	if !wallet_input_b.text.empty():
		wallets.append(wallet_input_b.text)
		amounts.append(amount_input_b.text.to_float())
		references.append(reference_input_b.text.to_int())
	if !wallet_input_c.text.empty():
		wallets.append(wallet_input_c.text)
		amounts.append(amount_input_c.text.to_float())
		references.append(reference_input_c.text.to_int())
	var res = MetaFab.batch_transfer_currency(self, "_on_transfer_result", 
		currency_input.text, token_input.text, password_input.text,
		wallets, references, amounts
	)
	if res == MetaFabRequest.Ok: txn_info.clear()
	else: txn_info.show_error(-1, name, res)

func _on_transfer_pressed():
	print("[%s] _on_transfer_pressed: %s" % [name, currency_input.text])
	var res = MetaFab.transfer_currency(self, "_on_transfer_result", 
		currency_input.text, token_input.text, password_input.text,
		wallet_input_a.text, reference_input_a.text.to_int(), 
		amount_input_a.text.to_float()
	)
	if res == MetaFabRequest.Ok: txn_info.clear()
	else: txn_info.show_error(-1, name, res)

func _on_transfer_result(code: int, result: String):
	var json = JSON.parse(result)
	if code == 200: txn_info.show_data(json.result)
	else: txn_info.show_error(name, code, json.result)

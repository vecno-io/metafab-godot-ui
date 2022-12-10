extends Container

onready var txn_info = get_node("%TxnInfo")

onready var error_box = get_node("%ErrorBox")
onready var result_box = get_node("%ResultBox")

onready var id_input = get_node("%IdInput")
onready var get_button = get_node("%GetButton")
onready var set_button = get_node("%SetButton")

onready var recipient_input = get_node("%RecipientInput")
onready var amount_cap_input = get_node("%AmountCapInput")
onready var basis_points_input = get_node("%BasisPointsInput")
onready var fixed_amount_input = get_node("%FixedAmountInput")
onready var secretkey_input = get_node("%SecretKeyInput")
onready var password_input = get_node("%PasswordInput")

onready var recipient_field = get_node("%RecipientField")
onready var amount_cap_field = get_node("%AmountCapField")
onready var basis_points_field = get_node("%BasisPointsField")
onready var fixed_amount_field = get_node("%FixedAmountField")

func _ready():
	get_button.connect("pressed", self, "_on_get_fees_pressed")
	set_button.connect("pressed", self, "_on_set_fees_pressed")

func _on_get_fees_pressed():
	print("[%s] _on_get_fees_pressed: %s" % [name, id_input.text])
	var res = MetaFab.get_currency_fees(self, "_on_get_fees_result", id_input.text)
	if res == MetaFabRequest.Ok: self._clear_fees()
	else: error_box.show_error(name, -1, res)

func _on_get_fees_result(code: int, result: String):
	var json = JSON.parse(result)
	if code == 200: self._show_get_data(json.result)
	else: self._show_fees_error(code, result)


func _on_set_fees_pressed():
	print("[%s] _on_set_fees_pressed: %s" % [name, id_input.text])
	var res = MetaFab.set_currency_fees(self, "_on_set_fees_result", id_input.text, recipient_input.text, 
		amount_cap_input.text.to_float(), fixed_amount_input.text.to_float(), basis_points_input.text.to_int(), 
		secretkey_input.text, password_input.text
	)
	if res == MetaFabRequest.Ok: self._clear_fees()
	else: error_box.show_error(name, -1, res)

func _on_set_fees_result(code: int, result: String):
	var json = JSON.parse(result)
	if code == 200: 
		self._on_get_fees_pressed()
		txn_info.show_data(json.result)
	else: 
		txn_info.show_error(name, code, result)

func _clear_fees():
	txn_info.clear()
	error_box.hide()
	error_box.clear()
	result_box.visible = false
	recipient_field.text = ""
	amount_cap_field.text = ""
	basis_points_field.text = ""
	fixed_amount_field.text = ""

func _show_get_data(data: Dictionary):
	self._show_fees_data(data)
	if data.has("recipientAddress"):
		recipient_input.text = data["recipientAddress"]
	if data.has("capAmount"):
		amount_cap_input.text = "%s" % data["capAmount"]
	if data.has("basisPoints"):
		basis_points_input.text = "%s" % data["basisPoints"]
	if data.has("fixedAmount"):
		fixed_amount_input.text = "%s" % data["fixedAmount"]

func _show_fees_data(data: Dictionary):
	error_box.hide()
	result_box.visible = true
	if !data.has("recipientAddress"): recipient_field.text = ""
	else: recipient_field.text = data["recipientAddress"]
	if !data.has("capAmount"): amount_cap_field.text = ""
	else: amount_cap_field.text = "%s" % data["capAmount"]
	if !data.has("basisPoints"): basis_points_field.text = ""
	else: basis_points_field.text = "%s" % data["basisPoints"]
	if !data.has("fixedAmount"): fixed_amount_field.text = ""
	else: fixed_amount_field.text = "%s" % data["fixedAmount"]

func _show_fees_error(code: int, message: String):
	result_box.visible = false
	error_box.show_error(name, code, message)

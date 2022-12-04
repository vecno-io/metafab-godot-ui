extends Container
 
onready var box_error = get_node("%Scroll-Error")
onready var box_result = get_node("%Scroll-Result")

onready var id_input = get_node("%GameIdInput")
onready var key_input = get_node("%SecretKeyInput")
onready var name_input = get_node("%NameInput")
onready var email_input = get_node("%EMailInput")
onready var new_pass_input = get_node("%NewPasswordInput")
onready var old_pass_input = get_node("%OldPasswordInput")
onready var public_key_bool = get_node("%ResetPublicKey")
onready var secret_key_bool = get_node("%ResetSecretKey")
onready var submit_button = get_node("%SubmitButton")

onready var name_field = get_node("%NameField")
onready var gameid_field = get_node("%GameIdField")
onready var created_field = get_node("%CreatedAtField")
onready var updated_field = get_node("%UpdatedAtField")
onready var secret_field = get_node("%SecretKeyField")
onready var published_field = get_node("%PublishedKeyField")

onready var wallet_id_field = get_node("%WalletIdField")
onready var wallet_acc_field = get_node("%WalletAccField")
onready var funding_id_field = get_node("%FundingIdField")
onready var funding_acc_field = get_node("%FundingAccField")

onready var error_code_field = get_node("%ErrorCodeField")
onready var error_message_field = get_node("%ErrorMessageField")


func _ready():
	submit_button.connect("pressed", self, "_on_submit_pressed")


func _on_submit_pressed():
	print("[%s] _on_submit_pressed: get: %s" % [name, id_input.text])
	var game_info = {}
	game_info["resetSecretKey"] = secret_key_bool.pressed
	game_info["resetPublishedKey"] = public_key_bool.pressed
	if !name_input.text.empty(): game_info["name"] = name_input.text
	if !email_input.text.empty(): game_info["email"] = email_input.text
	if !new_pass_input.text.empty(): game_info["newPassword"] = new_pass_input.text
	if !old_pass_input.text.empty(): game_info["currentPassword"] = old_pass_input.text
	var res = MetaFab.update_game(self, "_on_request_result", id_input.text, key_input.text, game_info)
	if res == MetaFabRequest.Ok: self._clear_data()
	else: self._set_error_data(-1, res)

func _on_request_result(code: int, result: String):
	var json = JSON.parse(result)
	if code == 200: self._set_game_data(json.result)
	else: self._set_error_data(code, json.result)


func _clear_data():
	box_error. visible = false
	box_result. visible = false
	name_field.text = ""
	gameid_field.text = ""
	created_field.text = ""
	updated_field.text = ""
	secret_field.text = ""
	published_field.text = ""
	wallet_id_field.text = ""
	wallet_acc_field.text = ""
	funding_id_field.text = ""
	funding_acc_field.text = ""
	error_code_field.text = ""
	error_message_field.text = ""

func _set_game_data(data: Dictionary):
	box_error. visible = false
	box_result. visible = true
	print("[%s] result: %s" % [name, data])
	if data.has("id"):
		gameid_field.text = data.id
	if data.has("name"): 
		name_field.text = data.name
	if data.has("createdAt"): 
		created_field.text = data.createdAt
	if data.has("updatedAt"):
		updated_field.text = data.updatedAt
	if data.has("secretKey"):
		secret_field.text = data.secretKey
	if data.has("publishedKey"):
		published_field.text = data.publishedKey
	if data.has("wallet"):
		if data.wallet.has("id"):
			wallet_id_field.text = data.wallet.id
		if data.wallet.has("address"):
			wallet_acc_field.text = data.wallet.address
	if data.has("fundingWallet"):
		if data.fundingWallet.has("id"):
			funding_id_field.text = data.fundingWallet.id
		if data.fundingWallet.has("address"):
			funding_acc_field.text = data.fundingWallet.address

func _set_error_data(code: int, message: String):
	box_error. visible = true
	box_result. visible = false
	error_code_field.text = "%s" % code
	error_message_field.text = message
	print("[%s] error: %s" % [name, code])
	print("[%s] msg: %s" % [name, message])
	

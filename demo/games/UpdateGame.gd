extends Container
 
onready var error_box = get_node("%ErrorBox")
onready var game_result = get_node("%GameResult")

onready var id_input = get_node("%GameIdInput")
onready var key_input = get_node("%SecretKeyInput")
onready var name_input = get_node("%NameInput")
onready var email_input = get_node("%EMailInput")
onready var new_pass_input = get_node("%NewPasswordInput")
onready var old_pass_input = get_node("%OldPasswordInput")
onready var icon_img_input = get_node("%IconBase64Input")
onready var cover_img_input = get_node("%CoverBase64Input")
onready var redirect_url_input = get_node("%RedirectUrlInput")
onready var public_key_bool = get_node("%ResetPublicKey")
onready var secret_key_bool = get_node("%ResetSecretKey")
onready var submit_button = get_node("%SubmitButton")

func _ready():
	submit_button.connect("pressed", self, "_on_submit_pressed")


func _on_submit_pressed():
	print("[%s] _on_submit_pressed: %s" % [name, id_input.text])
	# Note: In real world cases it might be wise to hash 
	# the password with the game id for increased security.
	var res = MetaFab.update_game(
		self, "_on_request_result", id_input.text, key_input.text, name_input.text, email_input.text, 
		icon_img_input.txt, cover_img_input.txt, old_pass_input.text, new_pass_input.text, 
		{}, [redirect_url_input.text], secret_key_bool.pressed, public_key_bool.pressed
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
	game_result.hide()
	game_result.clear()

func _show_data(data: Dictionary):
	error_box.hide()
	game_result.show_result(name, data)

func _show_error(code: int, message: String):
	game_result.hide()
	error_box.show_error(name, code, message)
	

extends Container

onready var error_box = get_node("%ErrorBox")
onready var player_result = get_node("%PlayerResult")

onready var publickey_input = get_node("%PublicKeyInput")
onready var username_input = get_node("%UsernameInput")
onready var password_input = get_node("%PasswordInput")
onready var submit_button = get_node("%SubmitButton")

func _ready():
	submit_button.connect("pressed", self, "_on_submit_pressed")


func _on_submit_pressed():
	print("[%s] _on_submit_pressed: %s" % [name, username_input.text])
	# Note: In real world cases it might be wise to hash 
	# the password with the game id for increased security.
	var res = MetaFab.auth_player(
		self, "_on_request_result", publickey_input.text, 
		username_input.text, password_input.text
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
	player_result.hide()
	player_result.clear()

func _show_data(data: Dictionary):
	error_box.hide()
	player_result.show_result(name, data)

func _show_error(code: int, message: String):
	player_result.hide()
	error_box.show_error(name, code, message)

extends Container

onready var error_box = get_node("%ErrorBox")
onready var player_result = get_node("%PlayerResult")

onready var id_input = get_node("%PlayerIdInput")
onready var token_input = get_node("%AccessTokenInput")
onready var old_pass_input = get_node("%OldPasswordInput")
onready var new_pass_input = get_node("%NewPasswordInput")
onready var reset_token_check = get_node("%ResetTokenCheck")
onready var submit_button = get_node("%SubmitButton")

func _ready():
	submit_button.connect("pressed", self, "_on_submit_pressed")

func _on_submit_pressed():
	print("[%s] _on_submit_pressed: %s" % [name, id_input.text])
	# Note: In real world cases it might be wise to hash 
	# the password with the game id for increased security.
	var res = MetaFab.update_player(
		self, "_on_request_result", id_input.text, token_input,
		old_pass_input.text, new_pass_input.text, reset_token_check.pressed
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

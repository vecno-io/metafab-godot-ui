extends Container

onready var error_box = get_node("%ErrorBox")
onready var game_result = get_node("%GameResult")

onready var gameid_input = get_node("%GameIdInput")
onready var submit_button = get_node("%SubmitButton")

func _ready():
	submit_button.connect("pressed", self, "_on_submit_pressed")


func _on_submit_pressed():
	print("[%s] _on_submit_pressed: %s" % [name, gameid_input.text])
	var res = MetaFab.get_game(self, "_on_request_result", gameid_input.text)
	if res == MetaFabRequest.Ok: self._clear()
	else: error_box.show_error(name, -1, res)

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

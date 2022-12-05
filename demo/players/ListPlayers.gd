extends Container

onready var error_box = get_node("%ErrorBox")

onready var result_box = get_node("%ResultBox")
onready var result_list = get_node("%ResultList")

onready var secretkey_input = get_node("%SecretKey")
onready var submit_button = get_node("%SubmitButton")

var ListItem = preload("res://demo/players/ListItem.tscn")

func _ready():
	submit_button.connect("pressed", self, "_on_submit_pressed")

func _on_submit_pressed():
	print("[%s] _on_submit_pressed" % [name])
	var res = MetaFab.get_players(self, "_on_request_result", secretkey_input.text)
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
	for item in result_list.get_children():
		item.queue_free()

func _show_data(data: Array):
	error_box.hide()
	for player in data:
		var item = ListItem.instance()
		result_list.add_child(item)
		item.set_info(player)
	result_box.visible = true

func _show_error(code: int, message: String):
	result_box.visible = false
	error_box.show_error(name, code, message)

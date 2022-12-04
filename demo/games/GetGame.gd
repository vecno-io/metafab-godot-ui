extends Container
 
onready var box_error = get_node("%Scroll-Error")
onready var box_result = get_node("%Scroll-Result")

onready var gameid_input = get_node("%GameIdInput")
onready var submit_button = get_node("%SubmitButton")

onready var name_field = get_node("%NameField")
onready var gameid_field = get_node("%GameIdField")
onready var created_field = get_node("%CreatedAtField")
onready var updated_field = get_node("%UpdatedAtField")
onready var published_field = get_node("%PublishedKeyField")

onready var error_code_field = get_node("%ErrorCodeField")
onready var error_message_field = get_node("%ErrorMessageField")


func _ready():
	submit_button.connect("pressed", self, "_on_submit_pressed")


func _on_submit_pressed():
	print("[%s] _on_submit_pressed: get: %s" % [name, gameid_input.text])
	var res = MetaFab.get_game(self, "_on_request_result", gameid_input.text)
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
	published_field.text = ""
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
	if data.has("publishedKey"):
		published_field.text = data.publishedKey

func _set_error_data(code: int, message: String):
	box_error. visible = true
	box_result. visible = false
	error_code_field.text = "%s" % code
	error_message_field.text = message
	print("[%s] error: %s" % [name, code])
	print("[%s] msg: %s" % [name, message])
	

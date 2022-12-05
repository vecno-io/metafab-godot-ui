extends Container

onready var error_box = get_node("%ErrorBox")
onready var result_box = get_node("%ResultBox")

onready var player_id = get_node("%PlayerId")
onready var player_get = get_node("%PlayerGetButton")
onready var player_token = get_node("%PlayerToken")
onready var player_set = get_node("%PlayerSetButton")
onready var secret_token = get_node("%SecretToken")
onready var secret_set = get_node("%SecretSetButton")

onready var name_input = get_node("%NameInput")
onready var volume_input = get_node("%VolumeInput")
onready var wisdom_input = get_node("%WisdomInput")
onready var strength_input = get_node("%StrengthInput")

onready var name_field = get_node("%NameField")
onready var volume_field = get_node("%VolumeField")
onready var wisdom_field = get_node("%WisdomField")
onready var strength_field = get_node("%StrengthField")

func _ready():
	player_get.connect("pressed", self, "_on_player_get")
	player_set.connect("pressed", self, "_on_player_set")
	secret_set.connect("pressed", self, "_on_secret_set")


func _on_player_get():
	print("[%s] _on_player_get: %s" % [name, player_id.text])
	var res = MetaFab.get_player_data(self, "_on_player_data_result", player_id.text)
	if res == MetaFabRequest.Ok: self._clear()
	else: self._show_error(-1, res)

func _on_player_set():
	print("[%s] _on_player_set: %s" % [name, player_id.text])
	var data = {}
	data["publicData"] = {}
	if !name_input.text.empty(): data.publicData["name"] = name_input.text
	if !volume_input.text.empty(): data.publicData["volume"] = volume_input.text
	var res = MetaFab.set_player_data(self, "_on_player_data_result", player_id.text, player_token.text, data)
	if res == MetaFabRequest.Ok: self._clear()
	else: self._show_error(-1, res)

func _on_secret_set():
	print("[%s] _on_secret_set: %s" % [name, player_id.text])
	var data = {}
	data["protectedData"] = {}
	if !wisdom_input.text.empty(): data.protectedData["wisdom"] = wisdom_input.text
	if !strength_input.text.empty(): data.protectedData["strength"] = strength_input.text
	var res = MetaFab.set_player_data(self, "_on_player_data_result", player_id.text, secret_token.text, data)
	if res == MetaFabRequest.Ok: self._clear()
	else: self._show_error(-1, res)

func _on_player_data_result(code: int, result: String):
	var json = JSON.parse(result)
	print("> Data: %s" % json.result)
	if code == 200: self._show_data(json.result)
	else: self._show_error(code, json.result)


func _clear():
	error_box.hide()
	error_box.clear()
	result_box.visible = false
	name_field.text = ""
	volume_field.text = ""
	wisdom_field.text = ""
	strength_field.text = ""

func _show_data(data: Dictionary):
	error_box.hide()
	if data.has("publicData"):
		if !data.publicData.has("name"): name_field.text = "aa"
		else: name_field.text = data.publicData.name
		if !data.publicData.has("volume"): volume_field.text = "bb"
		else: volume_field.text = data.publicData.volume
	if data.has("protectedData"):
		if !data.protectedData.has("wisdom"): wisdom_field.text = "cc"
		else: wisdom_field.text = data.protectedData.wisdom
		if !data.protectedData.has("strength"): strength_field.text = "dd"
		else: strength_field.text = data.protectedData.strength
	result_box.visible = true

func _show_error(code: int, message: String):
	result_box.visible = false
	error_box.show_error(name, code, message)

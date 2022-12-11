extends Container

onready var error_box = get_node("%ErrorBox")
onready var result_box = get_node("%ResultBox")

onready var object_id_field = get_node("%ObjectIdField")
onready var contract_id_field = get_node("%ContractIdField")

func clear():
	error_box.hide()
	error_box.clear()
	result_box.visible = false
	object_id_field.text = ""
	contract_id_field.text = ""

func show_data(data: Dictionary):
	error_box.hide()
	result_box.visible = true
	if !data.has("id"): object_id_field.text = "unknown"
	else: object_id_field.text = data["id"]
	if !data.has("contractId"): contract_id_field.text = "unknown"
	else: contract_id_field.text = data["contractId"]

func show_error(name: String, code: int, message: String):
	result_box.visible = false
	error_box.show_error(name, code, message)
extends Container

onready var _id = get_node("%IdField")
onready var _hash = get_node("%HashField")
onready var _method = get_node("%MethodField")

func set_info(data: Dictionary):
	_id = get_node("%IdField")
	if !data.has("id"): _id.text = ""
	else: _id.text = data["id"]
	_hash = get_node("%HashField")
	if !data.has("hash"): _hash.text = ""
	else: _hash.text = data["hash"]
	_method = get_node("%MethodField")
	if !data.has("function"): _method.text = ""
	else: _method.text = data["function"]

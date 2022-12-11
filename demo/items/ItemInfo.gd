extends Container

signal select(data)

var item_data = {}

onready var _id_field = get_node("%IdField")
onready var _name_field = get_node("%NameField")
onready var _descr_field = get_node("%DescrField")

onready var _select_button = get_node("%SelectButton")


func _ready():
	_select_button.connect("pressed", self, "_on_select_pressed")

func _on_select_pressed():
	emit_signal("select", item_data)


func set_info(data: Dictionary):
	self.item_data = data
	if !data.has("id"): _id_field.text = ""
	else: _id_field.text = "%s" % data["id"]
	if !data.has("name"): _name_field.text = ""
	else: _name_field.text = data["name"]
	if !data.has("description"): _descr_field.text = ""
	else: _descr_field.text = data["description"]

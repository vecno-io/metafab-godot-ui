extends PopupDialog

signal save_data(data)

onready var add_button = get_node("%AddButton")
onready var save_button = get_node("%SaveButton")
onready var close_button = get_node("%CloseButton")

onready var edit_buttons = get_node("%EditButtons")
onready var view_buttons = get_node("%ViewButtons")

onready var attribute_list = get_node("%AttributeList")

export var editable = true setget set_editable

var Attribute_Item = preload("res://demo/items/AttributeItem.tscn")

func _ready():
	self._set_button_options(editable)
	add_button.connect("pressed", self, "_on_add_button")
	save_button.connect("pressed", self, "_on_save_button")
	close_button.connect("pressed", self, "_on_close_button")

func set_editable(value: bool) -> void:
	editable = value
	self._set_button_options(editable)
	for item in attribute_list.get_children():
		if item.has("editable"): item.editable = value


func set_data(data: Array):
	self._clear_data()
	for obj in data:
		if obj.has("trait_type") && obj.has("value"):
			self._add_data(obj["trait_type"], obj["value"])

func _add_data(key: String, value: String):
	var item = Attribute_Item.instance()
	attribute_list.add_child(item)
	item.set_into(key, value)
	item.editable = editable

func _clear_data():
	for item in attribute_list.get_children():
		item.queue_free()


func _on_add_button():
	var item = Attribute_Item.instance()
	attribute_list.add_child(item)
	item.editable = editable

func _on_save_button():
	var data = self._build_result()
	emit_signal("save_data", data)
	self.hide()

func _on_close_button():
	self.hide()


func _build_result() -> Array:
	var result = []
	for item in attribute_list.get_children():
		if item.has_method("has_type") && item.has_type(): result.append({
			"trait_type": item.get_type(),
			"value": item.get_value()
		})
	return result

func _set_button_options(show_edit: bool):
	if show_edit:
		edit_buttons.visible = true
		view_buttons.visible = false
	else:
		edit_buttons.visible = false
		view_buttons.visible = true
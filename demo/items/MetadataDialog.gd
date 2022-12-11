extends PopupDialog

signal save_data(data)

onready var add_button = get_node("%AddButton")
onready var save_button = get_node("%SaveButton")
onready var close_button = get_node("%CloseButton")

onready var edit_buttons = get_node("%EditButtons")
onready var view_buttons = get_node("%ViewButtons")

onready var metadata_List = get_node("%MetadataList")

export var editable = true setget set_editable

var Metadata_Item = preload("res://demo/items/MetadataItem.tscn")

func _ready():
	self._set_button_options(editable)
	add_button.connect("pressed", self, "_on_add_button")
	save_button.connect("pressed", self, "_on_save_button")
	close_button.connect("pressed", self, "_on_close_button")

func set_editable(value: bool) -> void:
	editable = value
	self._set_button_options(editable)
	for item in metadata_List.get_children():
		if item.has("editable"): item.editable = value


func set_data(data: Dictionary):
	self._clear_data()
	for key in data:
		var value = data[key]
		self._add_data(key, value)

func _add_data(key: String, value: String):
	var item = Metadata_Item.instance()
	metadata_List.add_child(item)
	item.set_into(key, value)
	item.editable = editable

func _clear_data():
	for item in metadata_List.get_children():
		item.queue_free()


func _on_add_button():
	var item = Metadata_Item.instance()
	metadata_List.add_child(item)
	item.editable = editable

func _on_save_button():
	var data = self._build_result()
	emit_signal("save_data", data)
	self.hide()

func _on_close_button():
	self.hide()


func _build_result() -> Dictionary:
	var result = {}
	for item in metadata_List.get_children():
		if item.has_method("has_key") && item.has_key():
			result[item.get_key()] = item.get_value()
	return result

func _set_button_options(show_edit: bool):
	if show_edit:
		edit_buttons.visible = true
		view_buttons.visible = false
	else:
		edit_buttons.visible = false
		view_buttons.visible = true

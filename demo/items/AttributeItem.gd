class_name AttributeItem
extends Container

onready var item_type = get_node("%ItemType")
onready var item_value = get_node("%ItemValue")

export var editable = true setget set_editable

func _ready():
	item_type.editable = editable
	item_value.editable = editable

func set_editable(value: bool) -> void:
	editable = value
	item_type = get_node("%ItemType")
	item_type.editable = value
	item_value = get_node("%ItemValue")
	item_value.editable = value


func has_type() -> bool:
	if item_type == null: return false
	return !item_type.text.empty()

func get_type() -> String:
	if item_type == null: return ""
	return item_type.text

func get_value() -> String:
	if item_value == null: return ""
	return item_value.text

func set_into(type: String, value: String):
	item_type = get_node("%ItemType")
	item_type.text = type
	item_value = get_node("%ItemValue")
	item_value.text = value

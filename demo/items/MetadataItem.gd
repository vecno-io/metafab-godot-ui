class_name MetadataItem
extends Container

onready var item_key = get_node("%ItemKey")
onready var item_value = get_node("%ItemValue")

export var editable = true setget set_editable

func _ready():
	item_key.editable = editable
	item_value.editable = editable

func set_editable(value: bool) -> void:
	editable = value
	item_key = get_node("%ItemKey")
	item_key.editable = value
	item_value = get_node("%ItemValue")
	item_value.editable = value


func has_key() -> bool:
	if item_key == null: return false
	return !item_key.text.empty()

func get_key() -> String:
	if item_key == null: return ""
	return item_key.text

func get_value() -> String:
	if item_value == null: return ""
	return item_value.text

func set_into(key: String, value: String):
	item_key = get_node("%ItemKey")
	item_key.text = key
	item_value = get_node("%ItemValue")
	item_value.text = value

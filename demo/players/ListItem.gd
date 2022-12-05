extends VBoxContainer

onready var id_field = get_node("%IdField")
onready var name_field = get_node("%NameField")

func set_info(data: Dictionary):
	id_field.text = data.id
	name_field.text = data.username
	print("> Username: %s" % data.username)

extends Container

onready var _error_code = get_node("%ErrorCode")
onready var _error_message = get_node("%ErrorMessage")

func hide():
	self.visible = false

func clear():
	_error_code.text = ""
	_error_message.text = ""

func show_error(name: String, code: int, message: String):
	print("[%s] error: %s | %s" % [name, code, message])
	_error_code.text = "%s" % code
	_error_message.text = message
	self.visible = true

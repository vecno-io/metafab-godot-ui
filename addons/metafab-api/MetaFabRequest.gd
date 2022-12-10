class_name MetaFabRequest
extends HTTPRequest


"""
	Request Handler
"""

var call_object: Object
var call_function: String

func _ready():
	self.connect("request_completed", self, "_on_request_completed")

func _on_request_completed(result: int, response_code: int, headers:  PoolStringArray, body: PoolByteArray):
	self.call_object.call(call_function, response_code, body.get_string_from_utf8())
	self.disconnect("request_completed", self, "_on_request_completed")
	# Note: Unhandle result codes, server offline and so on
	self.queue_free()


"""
	Error Utilities
"""

const Ok = "ok"
const Error = "[%s] unkown error"
const Error_Busy = "[%s] client is bussy"
const Error_Cant_Connect = "[%s] can not connect"
const Error_Invalid_Params  = "[%s] url is not valid"

static func get_error(error: int) -> String:
	match error:
		ERR_BUSY: return Error_Busy
		ERR_CANT_CONNECT: return Error_Cant_Connect
		ERR_INVALID_PARAMETER: return Error_Invalid_Params
	return Error
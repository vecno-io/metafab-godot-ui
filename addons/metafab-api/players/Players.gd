class_name MetaFabPlayers
extends MetaFabRequest


const ERROR_NOT_IMPLEMENTED = "[players.%s] API Call not implemented"


func get_player() -> String:
	return ERROR_NOT_IMPLEMENTED % "get_player"

func get_players() -> String:
	return ERROR_NOT_IMPLEMENTED % "get_players"


func auth_player() -> String:
	return ERROR_NOT_IMPLEMENTED % "auth_player"

func create_player() -> String:
	return ERROR_NOT_IMPLEMENTED % "create_player"


func get_player_data() -> String:
	return ERROR_NOT_IMPLEMENTED % "get_player_data"

func set_player_data() -> String:
	return ERROR_NOT_IMPLEMENTED % "set_player_data"
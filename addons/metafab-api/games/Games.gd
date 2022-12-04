class_name MetaFabGames
extends MetaFabRequest


const ERROR_NOT_IMPLEMENTED = "[games.%s] API Call not implemented"


func get_game() -> String:
	return ERROR_NOT_IMPLEMENTED % "get_game"


func create_game() -> String:
	return ERROR_NOT_IMPLEMENTED % "create_game"

func update_game() -> String:
	return ERROR_NOT_IMPLEMENTED % "update_game"


func authenticate_game() -> String:
	return ERROR_NOT_IMPLEMENTED % "authenticate_game"

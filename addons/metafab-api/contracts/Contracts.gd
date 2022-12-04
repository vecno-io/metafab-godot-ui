class_name MetaFabContracts
extends MetaFabRequest


const ERROR_NOT_IMPLEMENTED = "[contracts.%s] API Call not implemented"


func get_contracts() -> String:
	return ERROR_NOT_IMPLEMENTED % "get_contracts"

func create_custom_contract() -> String:
	return ERROR_NOT_IMPLEMENTED % "create_custom_contract"

func read_contract_data() -> String:
	return ERROR_NOT_IMPLEMENTED % "read_contract_data"

func write_contract_data() -> String:
	return ERROR_NOT_IMPLEMENTED % "write_contract_data"


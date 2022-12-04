class_name MetaFabCurrencies
extends MetaFabRequest


const ERROR_NOT_IMPLEMENTED = "[currencies.%s] API Call not implemented"


func get_currencies() -> String:
	return ERROR_NOT_IMPLEMENTED % "get_currencies"

func get_currency_balance() -> String:
	return ERROR_NOT_IMPLEMENTED % "get_currency_balance"

func create_currency() -> String:
	return ERROR_NOT_IMPLEMENTED % "create_currency"


func mint_currency() -> String:
	return ERROR_NOT_IMPLEMENTED % "mint_currency"

func burn_currency() -> String:
	return ERROR_NOT_IMPLEMENTED % "burn_currency"


func get_currency_fees() -> String:
	return ERROR_NOT_IMPLEMENTED % "get_currency_fees"

func set_currency_fees() -> String:
	return ERROR_NOT_IMPLEMENTED % "set_currency_fees"


func get_currency_role() -> String:
	return ERROR_NOT_IMPLEMENTED % "get_currency_role"

func grant_currency_role() -> String:
	return ERROR_NOT_IMPLEMENTED % "grant_currency_role"

func revoke_currency_role() -> String:
	return ERROR_NOT_IMPLEMENTED % "revoke_currency_role"


func transfer_currency() -> String:
	return ERROR_NOT_IMPLEMENTED % "transfer_currency"

func batch_transfer_currency() -> String:
	return ERROR_NOT_IMPLEMENTED % "batch_transfer_currency"

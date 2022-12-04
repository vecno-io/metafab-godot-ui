class_name MetaFabWallets
extends MetaFabRequest


const ERROR_NOT_IMPLEMENTED = "[wallets.%s] API Call not implemented"


func get_wallet_balances() -> String:
	return ERROR_NOT_IMPLEMENTED % "get_wallet_balances"

func get_wallet_transactions() -> String:
	return ERROR_NOT_IMPLEMENTED % "get_wallet_transactions"
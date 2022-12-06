class_name MetaFabWallets
extends MetaFabRequest


const ERROR_NOT_IMPLEMENTED = "[wallets.%s] API Call not implemented"


func get_wallet_balances(wallet_id: String) -> String:
	var headers = ["accept: application/json"]
	var err = self.request(
		"https://api.trymetafab.com/v1/wallets/%s/balances" % wallet_id, 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func get_wallet_transactions(wallet_id: String) -> String:
	var headers = ["accept: application/json"]
	var err = self.request(
		"https://api.trymetafab.com/v1/wallets/%s/transactions" % wallet_id, 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

class_name MetaFabTransactions
extends MetaFabRequest


const ERROR_NOT_IMPLEMENTED = "[transactions.%s] API Call not implemented"


func get_transaction(transaction_id: String) -> String:
	var headers = ["accept: application/json"]
	var err = self.request(
		"https://api.trymetafab.com/v1/transactions/%s" % transaction_id, 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

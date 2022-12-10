class_name MetaFabCurrencies
extends MetaFabRequest


const ERROR_NOT_IMPLEMENTED = "[currencies.%s] API Call not implemented"


func get_currencies(game_pub_key: String) -> String:
	var headers = [
		"accept: application/json",
		"X-Game-Key: %s" % game_pub_key
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/currencies", 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func get_currency_balance(currency_id: String, wallet: String, id: bool = true) -> String:
	var headers = ["accept: application/json"]
	var query: String
	if id: query = "walletId"
	else: query = "address"
	var err = self.request(
		"https://api.trymetafab.com/v1/currencies/%s/balances?%s=%s" % [currency_id, query, wallet],
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func create_currency(secret_key: String, secret_password: String, chain: String, name: String, symbol: String, supply_cap: String) -> String:
	var payload = to_json({
		"chain": chain,
		"name": name,
		"symbol": symbol,
		"supplyCap": supply_cap.to_int(),
	})
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % secret_password,
		"X-Authorization: %s" % secret_key,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/currencies",
		headers, true, HTTPClient.METHOD_POST, payload
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok


func mint_currency(account_token: String, account_password: String, currency_id: String, wallet: String, amount: float, id: bool = true) -> String:
	var data = {}
	data["amount"] = amount
	if id: data["walletId"] = wallet
	else: data["address"] = wallet
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % account_password,
		"X-Authorization: %s" % account_token,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/currencies/%s/mints" % currency_id,
		headers, true, HTTPClient.METHOD_POST, to_json(data)
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func burn_currency(account_token: String, account_password: String, currency_id: String, amount: float) -> String:
	var payload = to_json({
		"amount": amount,
	})
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % account_password,
		"X-Authorization: %s" % account_token,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/currencies/%s/burns" % currency_id,
		headers, true, HTTPClient.METHOD_POST, payload
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok


func get_currency_fees(currency_id: String) -> String:
	var headers = [
		"accept: application/json",
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/currencies/%s/fees" % currency_id, 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func set_currency_fees(secret_key: String, secret_password: String, currency_id: String, recipient: String, cap_ammount: float, fixed_amount: float, basis_points: int) -> String:
	var payload = to_json({
		"recipientAddress": recipient,
		"capAmount": cap_ammount,
		"fixedAmount": fixed_amount,
		"basisPoints": basis_points
	})
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % secret_password,
		"X-Authorization: %s" % secret_key,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/currencies/%s/fees" % currency_id,
		headers, true, HTTPClient.METHOD_POST, payload
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok


func get_currency_role(currency_id: String, role: String, wallet: String, id: bool = true) -> String:
	var query = ""
	if id: query = "walletId=%s" % wallet
	else: query = "address=%s" % wallet
	var headers = [
		"accept: application/json",
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/currencies/%s/roles?role=%s&%s" % [currency_id, role, query], 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func grant_currency_role(account_token: String, account_password: String, currency_id: String, wallet: String, role: String, id: bool = true) -> String:
	var data = {}
	data["role"] = role
	if id: data["walletId"] = wallet
	else: data["address"] = wallet
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % account_password,
		"X-Authorization: %s" % account_token,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/currencies/%s/roles" % currency_id,
		headers, true, HTTPClient.METHOD_POST, to_json(data)
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func revoke_currency_role(account_token: String, account_password: String, currency_id: String, wallet: String, role: String, id: bool = true) -> String:
	var data = {}
	data["role"] = role
	if id: data["walletId"] = wallet
	else: data["address"] = wallet
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % account_password,
		"X-Authorization: %s" % account_token,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/currencies/%s/roles" % currency_id,
		headers, true, HTTPClient.METHOD_DELETE, to_json(data)
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok


func transfer_currency(account_token: String, account_password: String, currency_id: String, recipient: String, reference: int, amount: float, id: bool = true) -> String:
	var data = {}
	data["amount"] = amount
	data["reference"] = reference
	if id: data["walletId"] = recipient
	else: data["address"] = recipient
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % account_password,
		"X-Authorization: %s" % account_token,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/currencies/%s/transfers" % currency_id,
		headers, true, HTTPClient.METHOD_POST, to_json(data)
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func batch_transfer_currency(account_token: String, currency_id: String, account_password: String, recipients: Array, references: Array, amounts: Array, id: bool = true) -> String:
	var data = {}
	data["amounts"] = amounts
	data["references"] = references
	if id: data["walletIds"] = recipients
	else: data["addresses"] = recipients
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % account_password,
		"X-Authorization: %s" % account_token,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/currencies/%s/batchTransfers" % currency_id,
		headers, true, HTTPClient.METHOD_POST, to_json(data)
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

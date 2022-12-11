class_name MetaFabContracts
extends MetaFabRequest


const ERROR_NOT_IMPLEMENTED = "[contracts.%s] API Call not implemented"


func get_contracts(game_pub_key: String) -> String:
	var headers = [
		"accept: application/json",
		"X-Game-Key: %s" % game_pub_key
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/contracts", 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func create_custom_contract(secret_key: String, chain: String, address: String, forwarder: String, abi: String) -> String:
	var payload = to_json({
		"abi": abi,
		"chain": chain,
		"address": address,
		"forwarderAddress": forwarder,
	})
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Authorization: %s" % secret_key,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/contracts",
		headers, true, HTTPClient.METHOD_POST, payload
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func read_contract_data(contract_id: String, function: String, arguments: String) -> String:
	var headers = [
		"accept: application/json"
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/contracts/%s/reads?func=%s&args=%s" % [contract_id, function, arguments],
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func write_contract_data(account_token: String, account_password: String, contract_id: String, function: String, arguments: Array) -> String:
	var payload = to_json({
		"args": arguments,
		"func": function,
	})
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % account_password,
		"X-Authorization: %s" % account_token,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/contracts/%s/writes" % contract_id,
		headers, true, HTTPClient.METHOD_POST, payload
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

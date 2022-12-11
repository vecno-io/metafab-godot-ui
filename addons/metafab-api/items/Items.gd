class_name MetaFabItems
extends MetaFabRequest


const ERROR_NOT_IMPLEMENTED = "[items.%s] API Call not implemented"


func get_collections(public_key: String) -> String:
	var headers = [
		"accept: application/json",
		"X-Game-Key: %s" % public_key
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/collections", 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func get_collection_item(collection_id: String, item_id: int) -> String:
	var headers = [
		"accept: application/json",
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/collections/%s/items/%s" % [collection_id, item_id], 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func get_collection_items(collection_id: String) -> String:
	var headers = [
		"accept: application/json",
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/collections/%s/items" % collection_id,
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok


func create_collection(secret_key: String, password: String, chain: String) -> String:
	var payload = to_json({
		"chain": chain,
	})
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % password,
		"X-Authorization: %s" % secret_key,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/collections",
		headers, true, HTTPClient.METHOD_POST, payload
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func create_collection_item(
	account_token: String, account_password: String, collection_id: String, item_id: int, name: String, 
	descr: String, data_url: String, image_url: String, image_data: String, extra_data: Dictionary, attribute_data: Array
) -> String:
	var data = {
		"id": item_id,
		"name": name,
		"description": descr,
		"imageUrl": image_url,
		"imageBase64": image_data,
		"externalUrl": data_url,
		"data": extra_data,
		"attributes": attribute_data,
	}
	if !image_data.empty():
		data["imageBase64"] = image_data
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % account_password,
		"X-Authorization: %s" % account_token,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/collections/%s/items" % collection_id,
		headers, true, HTTPClient.METHOD_POST, to_json(data)
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok


func get_collection_item_supply(collection_id: String, item_id: int, wallet: String, id: bool = true) -> String:
	var headers = ["accept: application/json"]
	var query: String
	if id: query = "walletId=%s" % wallet
	else: query = "address=%s" % wallet
	var err = self.request(
		"https://api.trymetafab.com/v1/collections/%s/items/%s/supplies?%s" % [collection_id, item_id, query],
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func get_collection_item_balance(collection_id: String, item_id: int, wallet: String, id: bool = true) -> String:
	var headers = ["accept: application/json"]
	var query: String
	if id: query = "walletId=%s" % wallet
	else: query = "address=%s" % wallet
	var err = self.request(
		"https://api.trymetafab.com/v1/collections/%s/items/%s/balances?%s" % [collection_id, item_id, query],
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok


func get_collection_item_supplies(collection_id: String) -> String:
	var headers = [
		"accept: application/json",
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/collections/%s/supplies" % collection_id, 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func get_collection_item_balances(collection_id: String, wallet: String, id: bool = true) -> String:
	var headers = ["accept: application/json"]
	var query: String
	if id: query = "walletId=%s" % wallet
	else: query = "address=%s" % wallet
	var err = self.request(
		"https://api.trymetafab.com/v1/collections/%s/balances?%s" % [collection_id, query], 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok


func get_collection_role(collection_id: String, role: String, wallet: String, id: bool = true) -> String:
	var query = ""
	if id: query = "walletId=%s" % wallet
	else: query = "address=%s" % wallet
	var headers = [
		"accept: application/json",
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/collections/%s/roles?role=%s&%s" % [collection_id, role, query], 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func grant_collection_role(account_token: String, account_password: String, collection_id: String, role: String, wallet: String, id: bool = true) -> String:
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
		"https://api.trymetafab.com/v1/collections/%s/roles" % collection_id,
		headers, true, HTTPClient.METHOD_POST, to_json(data)
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func revoke_collection_role(account_token: String, account_password: String, collection_id: String, role: String, wallet: String, id: bool = true) -> String:
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
		"https://api.trymetafab.com/v1/collections/%s/roles" % collection_id,
		headers, true, HTTPClient.METHOD_DELETE, to_json(data)
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok


func get_collection_approval(collection_id: String, opperator: String, wallet: String, id: bool = true) -> String:
	var query = ""
	if id: query = "walletId=%s" % wallet
	else: query = "address=%s" % wallet
	var headers = [
		"accept: application/json",
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/collections/%s/approvals?operatorAddress=%s&%s" % [collection_id, opperator, query], 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func set_collection_approval(account_token: String, account_password: String, collection_id: String, opperator: String, approved: bool) -> String:
	var data = {
		"address": opperator,
		"approved": approved
	}
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % account_password,
		"X-Authorization: %s" % account_token,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/collections/%s/approvals" % collection_id,
		headers, true, HTTPClient.METHOD_POST, to_json(data)
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok


func burn_collection_item(account_token: String, account_password: String, collection_id: String, item_id: int, amount: int) -> String:
	var data = {
		"quantity": amount
	}
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % account_password,
		"X-Authorization: %s" % account_token,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/collections/%s/items/%s/burns" % [collection_id, item_id],
		headers, true, HTTPClient.METHOD_POST, to_json(data)
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func mint_collection_item(account_token: String, account_password: String, collection_id: String, item_id: int, amount: int, reciever: String, id: bool = true) -> String:
	var data = {
		"quantity": amount
	}
	if id: data["walletId"] = reciever
	else: data["address"] = reciever
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % account_password,
		"X-Authorization: %s" % account_token,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/collections/%s/items/%s/mints" % [collection_id, item_id],
		headers, true, HTTPClient.METHOD_POST, to_json(data)
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func batch_mint_collection_items(account_token: String, account_password: String, collection_id: String, item_ids: Array, amounts: Array, reciever: String, id: bool = true) -> String:
	var data = {
		"itemIds": item_ids,
		"quantities": amounts
	}
	if id: data["walletId"] = reciever
	else: data["address"] = reciever
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % account_password,
		"X-Authorization: %s" % account_token,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/collections/%s/batchMints" % collection_id,
		headers, true, HTTPClient.METHOD_POST, to_json(data)
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok


func transfer_collection_item(account_token: String, account_password: String, collection_id: String, item_id: int, amount: int, reciever: String, id: bool = true) -> String:
	var data = {
		"quantity": amount
	}
	if id: data["walletId"] = reciever
	else: data["address"] = reciever
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % account_password,
		"X-Authorization: %s" % account_token,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/collections/%s/items/%s/transfers" % [collection_id, item_id],
		headers, true, HTTPClient.METHOD_POST, to_json(data)
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func batch_transfer_collection_items(account_token: String, account_password: String, collection_id: String, item_ids: Array, amounts: Array, recievers: Array, id: bool = true) -> String:
	var data = {
		"itemIds": item_ids,
		"quantities": amounts
	}
	if id: data["walletIds"] = recievers
	else: data["addresses"] = recievers
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % account_password,
		"X-Authorization: %s" % account_token,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/collections/%s/batchTransfers" % collection_id,
		headers, true, HTTPClient.METHOD_POST, to_json(data)
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok


func get_collection_item_timelock(collection_id: String, item_id: int) -> String:
	var headers = [
		"accept: application/json",
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/collections/%s/items/%s/timelocks" % [collection_id, item_id], 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func set_collection_item_timelock(account_token: String, account_password: String, collection_id: String, item_id: int, timelock: int) -> String:
	var data = {
		"timelock": timelock
	}
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % account_password,
		"X-Authorization: %s" % account_token,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/collections/%s/items/%s/timelocks" % [collection_id, item_id],
		headers, true, HTTPClient.METHOD_POST, to_json(data)
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

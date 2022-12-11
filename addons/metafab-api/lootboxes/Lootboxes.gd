class_name MetaFabLootboxes
extends MetaFabRequest


const ERROR_NOT_IMPLEMENTED = "[lootboxes.%s] API Call not implemented"


func get_lootbox_managers(game_pub_key: String) -> String:
	var headers = [
		"accept: application/json",
		"X-Game-Key: %s" % game_pub_key
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/lootboxManagers", 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func get_lootbox_manager_lootboxes(manager_id: String) -> String:
	var headers = [
		"accept: application/json",
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/lootboxManagers/%s/lootboxes" % manager_id, 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok


func create_lootbox_manager(secret_key: String, secret_password: String, chain: String) -> String:
	var payload = to_json({
		"chain": chain,
	})
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % secret_password,
		"X-Authorization: %s" % secret_key,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/lootboxManagers",
		headers, true, HTTPClient.METHOD_POST, payload
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func get_lootbox_manager_lootbox(manager_id: String, lootbox_id: String) -> String:
	var headers = [
		"accept: application/json",
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/lootboxManagers/%s/lootboxes/%s" % [manager_id, lootbox_id], 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok


func set_lootbox_manager_lootbox(
	secret_key: String, secret_password: String, manager_id: String, lootbox_id: int,
	input_collection: String, output_collection: String, input_ids: Array, output_ids: Array,
	input_amounts: Array, output_amounts: Array, output_weights: Array, output_total: Array, 
	is_input_id: bool = true, is_output_id: bool = true
) -> String:
	var payload = {
		"id": lootbox_id,
		"inputCollectionItemIds": input_ids,
		"inputCollectionItemAmounts": input_amounts,
		"outputTotalItems": output_total,
		"outputCollectionItemIds": output_ids,
		"outputCollectionItemAmounts": output_amounts,
		"outputCollectionItemWeights": output_weights,
	}
	if is_input_id: payload["inputCollectionId"] = input_collection
	else:  payload["inputCollectionAddress"] = input_collection
	if is_output_id: payload["outputCollectionId"] = output_collection
	else:  payload["outputCollectionAddress"] = output_collection
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % secret_password,
		"X-Authorization: %s" % secret_key,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/lootboxManagers/%s/lootboxes" % manager_id, 
		headers, true, HTTPClient.METHOD_POST, to_json(payload)
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func remove_lootbox_manager_lootbox(secret_key: String, secret_password: String, manager_id: String, lootbox_id: String) -> String:
	var headers = [
		"accept: application/json",
		"X-Password: %s" % secret_password,
		"X-Authorization: %s" % secret_key,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/lootboxManagers/%s/lootboxes/%s" % [manager_id, lootbox_id], 
		headers, true, HTTPClient.METHOD_DELETE
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

	
func open_lootbox_manager_lootbox(account_token: String, account_password: String, manager_id: String, lootbox_id: String) -> String:
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % account_password,
		"X-Authorization: %s" % account_token,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/lootboxManagers/%s/lootboxes/%s/opens" % [manager_id, lootbox_id], 
		headers, true, HTTPClient.METHOD_POST
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

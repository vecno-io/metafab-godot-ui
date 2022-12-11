class_name MetaFabShops
extends MetaFabRequest


const ERROR_NOT_IMPLEMENTED = "[shops.%s] API Call not implemented"


func get_shops(game_pub_key: String) -> String:
	var headers = [
		"accept: application/json",
		"X-Game-Key: %s" % game_pub_key
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/shops", 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func get_shop_offer(shop_id: String, offer_id: String) -> String:
	var headers = [
		"accept: application/json",
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/shops/%s/items/%s" % [shop_id, offer_id], 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func get_shop_offers(shop_id: String) -> String:
	var headers = [
		"accept: application/json",
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/shops/%s/offers" % shop_id, 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok


func create_shop(secret_key: String, secret_password: String, chain: String) -> String:
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
		"https://api.trymetafab.com/v1/shops",
		headers, true, HTTPClient.METHOD_POST, payload
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok


func set_shop_offer(
	secret_key: String, secret_password: String, 
	shop_id: String, offer_id: int, max_uses: int,
	input_currency: String, output_currency: String, 
	input_currency_amounts: Array, output_currency_amounts: Array,
	input_collection: String, output_collection: String, 
	input_collection_ids: Array, output_collection_ids: Array,
	input_collection_amounts: Array, output_collection_amounts: Array,
	input_currency_id: bool = true, output_currency_id: bool = true, 
	input_collection_id: bool = true, output_collection_id: bool = true
) -> String:
	var payload = {
		"id": offer_id,
		"maxUses": max_uses,
		"inputCurrencyAmount": input_currency_amounts,
		"outputCurrencyAmount": output_currency_amounts,
		"inputCollectionItemIds": input_collection_ids,
		"outputCollectionItemIds": output_collection_ids,
		"inputCollectionItemAmounts": input_collection_amounts,
		"outputCollectionItemAmounts": output_collection_amounts,
	}
	if input_currency_id: payload["inputCurrencyId"] = input_currency
	else: payload["inputCurrencyAddress"] = input_currency
	if output_currency_id: payload["outputCurrencyId"] = output_currency
	else: payload["outputCurrencyAddress"] = output_currency
	if input_collection_id: payload["inputCollectionId"] = input_collection
	else: payload["inputCollectionAddress"] = input_collection
	if output_collection_id: payload["outputCollectionId"] = output_collection
	else: payload["outputCollectionAddress"] = output_collection
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % secret_password,
		"X-Authorization: %s" % secret_key,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/shops/%s/offers" % shop_id,
		headers, true, HTTPClient.METHOD_POST, to_json(payload)
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func remove_shop_offer(secret_key: String, secret_password: String, shop_id: String, offer_id: String) -> String:
	var headers = [
		"accept: application/json",
		"X-Password: %s" % secret_password,
		"X-Authorization: %s" % secret_key,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/shops/%s/offers/%s" % [shop_id, offer_id], 
		headers, true, HTTPClient.METHOD_DELETE
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok


func use_shop_offer(account_token: String, account_password: String, shop_id: String, offer_id: String) -> String:
	var headers = [
		"accept: application/json",
		"X-Password: %s" % account_password,
		"X-Authorization: %s" % account_token,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/shops/%s/offers/%s/uses" % [shop_id, offer_id], 
		headers, true, HTTPClient.METHOD_POST
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func withdraw_from_shop(
	secret_key: String, secret_password: String, shop_id: String,
	reciever: String, currency: String, collection: String, item_ids: Array,
	reciever_id: bool = true, currency_id: bool = true, collection_id: bool = true
) -> String:
	var payload = {
		"itemIds": item_ids,
	}
	if reciever_id: payload["walletId"] = reciever
	else: payload["address"] = reciever
	if currency_id: payload["currencyId"] = currency
	else: payload["currencyAddress"] = currency
	if collection_id: payload["collectionId"] = collection
	else: payload["collectionAddress"] = collection
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Password: %s" % secret_password,
		"X-Authorization: %s" % secret_key,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/shops/%s/withdrawals" % shop_id,
		headers, true, HTTPClient.METHOD_POST, to_json(payload)
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

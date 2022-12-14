class_name MetaFabGames
extends MetaFabRequest


const ERROR_NOT_IMPLEMENTED = "[games.%s] API Call not implemented"


func get_game(game_id: String) -> String:
	var headers = ["accept: application/json"]
	var err = self.request(
		"https://api.trymetafab.com/v1/games/%s" % game_id, 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok


func auth_game(email: String, password: String) -> String:
	var auth = Marshalls.utf8_to_base64("%s:%s" % [email, password])
	var headers = [
		"accept: application/json",
		"authorization: Basic %s" % auth
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/games/auth", 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func create_game(name: String, email: String, password: String) -> String:
	var payload = to_json({
		"name": name,
		"email": email,
		"password": password,
	})
	var headers = [
		"accept: application/json",
		"content-type: application/json",
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/games", 
		headers, true, HTTPClient.METHOD_POST, payload
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func update_game(
	game_id: String, secret_key: String, name: String, email: String, icon_base64: String, cover_base64: String, 
	old_password: String = "", new_password: String = "", rpcs: Dictionary = {}, redirects: Array = [], 
	reset_pub_key: bool = false, reset_priv_key: bool = false
) -> String:
	var payload = {
		"rpcs": rpcs,
		"redirectUris": redirects,
		"resetPublishedKey": reset_pub_key,
		"resetSecretKey": reset_priv_key,
	}
	if not name.empty(): 
		payload["name"] = name
	if not email.empty(): 
		payload["email"] = email
	if not old_password.empty(): 
		payload["currentPassword"] = old_password
	if not new_password.empty(): 
		payload["newPassword"] = new_password
	if not icon_base64.empty(): 
		payload["iconImageBase64"] = icon_base64
	if not cover_base64.empty(): 
		payload["coverImageBase64"] = cover_base64
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Authorization: %s" % secret_key,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/games/%s" % game_id, 
		headers, true, HTTPClient.METHOD_PATCH, to_json(payload)
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

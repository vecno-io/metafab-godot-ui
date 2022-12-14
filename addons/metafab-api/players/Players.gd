class_name MetaFabPlayers
extends MetaFabRequest


const ERROR_NOT_IMPLEMENTED = "[players.%s] API Call not implemented"


func get_player(player_id: String) -> String:
	var headers = ["accept: application/json"]
	var err = self.request(
		"https://api.trymetafab.com/v1/players/%s" % player_id, 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func get_players(game_priv_key: String) -> String:
	var headers = [
		"accept: application/json",
		"X-Authorization: %s" % game_priv_key
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/players",
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok


func auth_player(game_pub_key: String, username: String, password: String) -> String:
	var auth = Marshalls.utf8_to_base64("%s:%s" % [username, password])
	var headers = [
		"accept: application/json", 
		"X-Game-Key: %s" % game_pub_key,
		"authorization: Basic %s" % auth
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/players/auth", 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func create_player(game_pub_key: String, username: String, password: String) -> String:
	var payload = to_json({
		"username": username,
		"password": password,
	})
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Game-Key: %s" % game_pub_key
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/players", 
		headers, true, HTTPClient.METHOD_POST, payload
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func update_player(player_id: String, access_token: String, old_password: String = "", new_password: String = "", reset_access_token: bool = false) -> String:
	var payload = {
		"resetAccessToken": reset_access_token
	}
	if not old_password.empty():
		payload["currentPassword"] = old_password
	if not new_password.empty():
		payload["newPassword"] = new_password
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Authorization: %s" % access_token,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/players/%s" % player_id, 
		headers, true, HTTPClient.METHOD_PATCH, to_json(payload)
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func get_player_data(player_id: String) -> String:
	var headers = ["accept: application/json"]
	var err = self.request(
		"https://api.trymetafab.com/v1/players/%s/data" % player_id, 
		headers, true, HTTPClient.METHOD_GET
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

func set_player_data(player_id: String, access_token: String, player_data: Dictionary) -> String:
	var payload = to_json(player_data)
	var headers = [
		"accept: application/json",
		"content-type: application/json",
		"X-Authorization: %s" % access_token,
	]
	var err = self.request(
		"https://api.trymetafab.com/v1/players/%s/data" % player_id, 
		headers, true, HTTPClient.METHOD_POST, payload
	)
	if err != OK:  return MetaFabRequest.get_error(err) % name
	else: return MetaFabRequest.Ok

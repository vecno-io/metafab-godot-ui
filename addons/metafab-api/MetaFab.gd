extends Node

const ERROR_CALL_OBJECT = "invalid call object or fuction"

func _ready():
	pass



"""
	Currencies API
"""

func get_contracts(call_object: Object, call_function: String) -> String:
	var req = self._contracts_api_init(call_object, call_function)
	if req != null: return req.get_contracts()
	return ERROR_CALL_OBJECT


func create_custom_contract(call_object: Object, call_function: String) -> String:
	var req = self._contracts_api_init(call_object, call_function)
	if req != null: return req.create_custom_contract()
	return ERROR_CALL_OBJECT


func read_contract_data(call_object: Object, call_function: String) -> String:
	var req = self._contracts_api_init(call_object, call_function)
	if req != null: return req.read_contract_data()
	return ERROR_CALL_OBJECT

func write_contract_data(call_object: Object, call_function: String) -> String:
	var req = self._contracts_api_init(call_object, call_function)
	if req != null: return req.write_contract_data()
	return ERROR_CALL_OBJECT


var _contracts_api = preload("res://addons/metafab-api/contracts/Contracts.tscn")
func _contracts_api_init(call_object: Object, call_function: String) -> MetaFabContracts:
	if call_object.has_method(call_function):
		var req = _contracts_api.instance()
		req.call_function = call_function
		req.call_object = call_object
		add_child(req)
		return req
	return null



"""
	Currencies API
"""

func get_currencies(call_object: Object, call_function: String) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.get_currencies()
	return ERROR_CALL_OBJECT

func get_currency_balance(call_object: Object, call_function: String) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.get_currency_balance()
	return ERROR_CALL_OBJECT

func create_currency(call_object: Object, call_function: String) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.create_currency()
	return ERROR_CALL_OBJECT


func mint_currency(call_object: Object, call_function: String) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.mint_currency()
	return ERROR_CALL_OBJECT

func burn_currency(call_object: Object, call_function: String) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.burn_currency()
	return ERROR_CALL_OBJECT


func get_currency_fees(call_object: Object, call_function: String) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.get_currency_fees()
	return ERROR_CALL_OBJECT

func set_currency_fees(call_object: Object, call_function: String) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.set_currency_fees()
	return ERROR_CALL_OBJECT


func get_currency_role(call_object: Object, call_function: String) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.get_currency_role()
	return ERROR_CALL_OBJECT

func grant_currency_role(call_object: Object, call_function: String) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.grant_currency_role()
	return ERROR_CALL_OBJECT

func revoke_currency_role(call_object: Object, call_function: String) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.revoke_currency_role()
	return ERROR_CALL_OBJECT


func transfer_currency(call_object: Object, call_function: String) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.transfer_currency()
	return ERROR_CALL_OBJECT

func batch_transfer_currency(call_object: Object, call_function: String) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.batch_transfer_currency()
	return ERROR_CALL_OBJECT


var _currencies_api = preload("res://addons/metafab-api/currencies/Currencies.tscn")
func _currencies_api_init(call_object: Object, call_function: String) -> MetaFabCurrencies:
	if call_object.has_method(call_function):
		var req = _currencies_api.instance()
		req.call_function = call_function
		req.call_object = call_object
		add_child(req)
		return req
	return null



"""
	Games API
"""

func get_game(call_object: Object, call_function: String, game_id: String) -> String:
	var req = self._games_api_init(call_object, call_function)
	if req != null: return req.get_game(game_id)
	return ERROR_CALL_OBJECT


func auth_game(call_object: Object, call_function: String, email: String, password: String) -> String:
	var req = self._games_api_init(call_object, call_function)
	if req != null: return req.auth_game(email, password)
	return ERROR_CALL_OBJECT

func create_game(call_object: Object, call_function: String, name: String, email: String, password: String) -> String:
	var req = self._games_api_init(call_object, call_function)
	if req != null: return req.create_game(name, email, password)
	return ERROR_CALL_OBJECT

func update_game(call_object: Object, call_function: String, game_id: String, secret_key: String, game_info: Dictionary) -> String:
	var req = self._games_api_init(call_object, call_function)
	if req != null: return req.update_game(game_id, secret_key, game_info)
	return ERROR_CALL_OBJECT


var _games_api = preload("res://addons/metafab-api/games/Games.tscn")
func _games_api_init(call_object: Object, call_function: String) -> MetaFabGames:
	if call_object.has_method(call_function):
		var req = _games_api.instance()
		req.call_function = call_function
		req.call_object = call_object
		add_child(req)
		return req
	return null



"""
	Items API
"""

func get_collections(call_object: Object, call_function: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.get_collections()
	return ERROR_CALL_OBJECT

func get_collection_item(call_object: Object, call_function: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.get_collection_item()
	return ERROR_CALL_OBJECT

func get_collection_items(call_object: Object, call_function: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.get_collection_items()
	return ERROR_CALL_OBJECT


func create_collections(call_object: Object, call_function: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.create_collections()
	return ERROR_CALL_OBJECT

func create_collection_item(call_object: Object, call_function: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.create_collection_item()
	return ERROR_CALL_OBJECT


func get_collection_item_supply(call_object: Object, call_function: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.get_collection_item_supply()
	return ERROR_CALL_OBJECT

func get_collection_item_supplies(call_object: Object, call_function: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.get_collection_item_supplies()
	return ERROR_CALL_OBJECT

func get_collection_item_balance(call_object: Object, call_function: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.get_collection_item_balance()
	return ERROR_CALL_OBJECT

func get_collection_item_balances(call_object: Object, call_function: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.get_collection_item_balances()
	return ERROR_CALL_OBJECT


func get_collection_role(call_object: Object, call_function: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.get_collection_role()
	return ERROR_CALL_OBJECT

func grant_collection_role(call_object: Object, call_function: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.grant_collection_role()
	return ERROR_CALL_OBJECT

func revoke_collection_role(call_object: Object, call_function: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.revoke_collection_role()
	return ERROR_CALL_OBJECT

func get_collection_approval(call_object: Object, call_function: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.get_collection_approval()
	return ERROR_CALL_OBJECT

func set_collection_approval(call_object: Object, call_function: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.set_collection_approval()
	return ERROR_CALL_OBJECT


func burn_collection_item(call_object: Object, call_function: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.burn_collection_item()
	return ERROR_CALL_OBJECT

func mint_collection_item(call_object: Object, call_function: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.mint_collection_item()
	return ERROR_CALL_OBJECT

func batch_mint_collection_items(call_object: Object, call_function: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.batch_mint_collection_items()
	return ERROR_CALL_OBJECT

func transfer_collection_item(call_object: Object, call_function: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.transfer_collection_item()
	return ERROR_CALL_OBJECT

func batch_transfer_collection_items(call_object: Object, call_function: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.batch_transfer_collection_items()
	return ERROR_CALL_OBJECT

func get_collection_item_timelock(call_object: Object, call_function: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.get_collection_item_timelock()
	return ERROR_CALL_OBJECT

func set_collection_item_timelock(call_object: Object, call_function: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.set_collection_item_timelock()
	return ERROR_CALL_OBJECT


var _items_api = preload("res://addons/metafab-api/items/Items.tscn")
func _items_api_init(call_object: Object, call_function: String) -> MetaFabItems:
	if call_object.has_method(call_function):
		var req = _items_api.instance()
		req.call_function = call_function
		req.call_object = call_object
		add_child(req)
		return req
	return null



"""
	Lootboxes API
"""

func get_lootbox_managers(call_object: Object, call_function: String) -> String:
	var req = self._lootboxes_api_init(call_object, call_function)
	if req != null: return req.get_lootbox_managers()
	return ERROR_CALL_OBJECT

func get_lootbox_manager_lootboxes(call_object: Object, call_function: String) -> String:
	var req = self._lootboxes_api_init(call_object, call_function)
	if req != null: return req.get_lootbox_manager_lootboxes()
	return ERROR_CALL_OBJECT
	

func create_lootbox_manager(call_object: Object, call_function: String) -> String:
	var req = self._lootboxes_api_init(call_object, call_function)
	if req != null: return req.create_lootbox_manager()
	return ERROR_CALL_OBJECT
	
func get_lootbox_manager_lootbox(call_object: Object, call_function: String) -> String:
	var req = self._lootboxes_api_init(call_object, call_function)
	if req != null: return req.get_lootbox_manager_lootbox()
	return ERROR_CALL_OBJECT

func set_lootbox_manager_lootbox(call_object: Object, call_function: String) -> String:
	var req = self._lootboxes_api_init(call_object, call_function)
	if req != null: return req.set_lootbox_manager_lootbox()
	return ERROR_CALL_OBJECT

func remove_lootbox_manager_lootbox(call_object: Object, call_function: String) -> String:
	var req = self._lootboxes_api_init(call_object, call_function)
	if req != null: return req.remove_lootbox_manager_lootbox()
	return ERROR_CALL_OBJECT

	
func open_lootbox_manager_lootbox(call_object: Object, call_function: String) -> String:
	var req = self._lootboxes_api_init(call_object, call_function)
	if req != null: return req.open_lootbox_manager_lootbox()
	return ERROR_CALL_OBJECT


var _lootboxes_api = preload("res://addons/metafab-api/lootboxes/Lootboxes.tscn")
func _lootboxes_api_init(call_object: Object, call_function: String) -> MetaFabLootboxes:
	if call_object.has_method(call_function):
		var req = _lootboxes_api.instance()
		req.call_function = call_function
		req.call_object = call_object
		add_child(req)
		return req
	return null



"""
	Players API
"""

func get_player(call_object: Object, call_function: String, player_id: String) -> String:
	var req = self._players_api_init(call_object, call_function)
	if req != null: return req.get_player(player_id)
	return ERROR_CALL_OBJECT

func get_players(call_object: Object, call_function: String, game_priv_key: String) -> String:
	var req = self._players_api_init(call_object, call_function)
	if req != null: return req.get_players(game_priv_key)
	return ERROR_CALL_OBJECT


func auth_player(call_object: Object, call_function: String, game_pub_key: String, username: String, password: String) -> String:
	var req = self._players_api_init(call_object, call_function)
	if req != null: return req.auth_player(game_pub_key, username, password)
	return ERROR_CALL_OBJECT

func create_player(call_object: Object, call_function: String, game_pub_key: String, username: String, password: String) -> String:
	var req = self._players_api_init(call_object, call_function)
	if req != null: return req.create_player(game_pub_key, username, password)
	return ERROR_CALL_OBJECT

func update_player(call_object: Object, call_function: String, player_id: String, access_token: String, player_info: Dictionary) -> String:
	var req = self._players_api_init(call_object, call_function)
	if req != null: return req.update_player(player_id, access_token, player_info)
	return ERROR_CALL_OBJECT


func get_player_data(call_object: Object, call_function: String, player_id: String) -> String:
	var req = self._players_api_init(call_object, call_function)
	if req != null: return req.get_player_data(player_id)
	return ERROR_CALL_OBJECT

func set_player_data(call_object: Object, call_function: String, player_id: String, access_token: String, player_data: Dictionary) -> String:
	var req = self._players_api_init(call_object, call_function)
	if req != null: return req.set_player_data(player_id, access_token, player_data)
	return ERROR_CALL_OBJECT


var _players_api = preload("res://addons/metafab-api/players/Players.tscn")
func _players_api_init(call_object: Object, call_function: String) -> MetaFabPlayers:
	if call_object.has_method(call_function):
		var req = _players_api.instance()
		req.call_function = call_function
		req.call_object = call_object
		add_child(req)
		return req
	return null



"""
	Shops API
"""

func get_shops(call_object: Object, call_function: String) -> String:
	var req = self._shops_api_init(call_object, call_function)
	if req != null: return req.get_shops()
	return ERROR_CALL_OBJECT

func get_shop_offer(call_object: Object, call_function: String) -> String:
	var req = self._shops_api_init(call_object, call_function)
	if req != null: return req.get_shop_offer()
	return ERROR_CALL_OBJECT

func get_shop_offers(call_object: Object, call_function: String) -> String:
	var req = self._shops_api_init(call_object, call_function)
	if req != null: return req.get_shop_offers()
	return ERROR_CALL_OBJECT


func create_shop(call_object: Object, call_function: String) -> String:
	var req = self._shops_api_init(call_object, call_function)
	if req != null: return req.create_shop()
	return ERROR_CALL_OBJECT


func set_shop_offer(call_object: Object, call_function: String) -> String:
	var req = self._shops_api_init(call_object, call_function)
	if req != null: return req.set_shop_offer()
	return ERROR_CALL_OBJECT

func remove_shop_offer(call_object: Object, call_function: String) -> String:
	var req = self._shops_api_init(call_object, call_function)
	if req != null: return req.remove_shop_offer()
	return ERROR_CALL_OBJECT


func use_shop_offer(call_object: Object, call_function: String) -> String:
	var req = self._shops_api_init(call_object, call_function)
	if req != null: return req.use_shop_offer()
	return ERROR_CALL_OBJECT

func withdraw_from_shop(call_object: Object, call_function: String) -> String:
	var req = self._shops_api_init(call_object, call_function)
	if req != null: return req.withdraw_from_shop()
	return ERROR_CALL_OBJECT


var _shops_api = preload("res://addons/metafab-api/shops/Shops.tscn")
func _shops_api_init(call_object: Object, call_function: String) -> MetaFabShops:
	if call_object.has_method(call_function):
		var req = _shops_api.instance()
		req.call_function = call_function
		req.call_object = call_object
		add_child(req)
		return req
	return null



"""
	Transactions API
"""

func get_transaction(call_object: Object, call_function: String) -> String:
	var req = self._transactions_api_init(call_object, call_function)
	if req != null: return req.get_transaction()
	return ERROR_CALL_OBJECT


var _transactions_api = preload("res://addons/metafab-api/transactions/Transactions.tscn")
func _transactions_api_init(call_object: Object, call_function: String) -> MetaFabTransactions:
	if call_object.has_method(call_function):
		var req = _transactions_api.instance()
		req.call_function = call_function
		req.call_object = call_object
		add_child(req)
		return req
	return null



"""
	Wallets API
"""

func get_wallet_balances(call_object: Object, call_function: String, wallet_id: String) -> String:
	var req = self._wallets_api_init(call_object, call_function)
	if req != null: return req.get_wallet_balances(wallet_id)
	return ERROR_CALL_OBJECT

func get_wallet_transactions(call_object: Object, call_function: String, wallet_id: String) -> String:
	var req = self._wallets_api_init(call_object, call_function)
	if req != null: return req.get_wallet_transactions(wallet_id)
	return ERROR_CALL_OBJECT


var _wallets_api = preload("res://addons/metafab-api/wallets/Wallets.tscn")
func _wallets_api_init(call_object: Object, call_function: String) -> MetaFabWallets:
	if call_object.has_method(call_function):
		var req = _wallets_api.instance()
		req.call_function = call_function
		req.call_object = call_object
		add_child(req)
		return req
	return null

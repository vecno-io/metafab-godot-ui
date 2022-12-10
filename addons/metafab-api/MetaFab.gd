extends Node

const ERROR_CALL_OBJECT = "invalid call object or fuction"


"""
	Chain Info
"""

enum Chain {
	Unknown,
	Ethereum,     #ETHEREUM,
	EthereumTest, #GOERLI,
	Polygon,      #MATIC,
	PolygonTest,  #MATICMUMBAI,
	Arbitrum,     #ARBITRUM,
	ArbitrumTest, #ARBITRUMGOERLI,
}

const KEY_ETHEREUM = "ETHEREUM"
const KEY_GOERLI = "GOERLI"
const KEY_MATIC = "MATIC"
const KEY_MATICMUMBAI = "MATICMUMBAI"
const KEY_ARBITRUM = "ARBITRUM"
const KEY_ARBITRUMGOERLI = "ARBITRUMGOERLI"

func get_chain_id(key: String):
	match key:
		KEY_ETHEREUM: return Chain.Ethereum
		KEY_GOERLI: return Chain.EthereumTest
		KEY_MATIC: return Chain.Polygon
		KEY_MATICMUMBAI: return Chain.PolygonTest
		KEY_ARBITRUM: return Chain.Arbitrum
		KEY_ARBITRUMGOERLI: return Chain.ArbitrumTest
	return Chain.Unknown

func get_chain_key(chain: int):
	match chain:
		Chain.Ethereum: return KEY_ETHEREUM
		Chain.EthereumTest: return KEY_GOERLI
		Chain.Polygon: return KEY_MATIC
		Chain.PolygonTest: return KEY_MATICMUMBAI
		Chain.Arbitrum: return KEY_ARBITRUM
		Chain.ArbitrumTest: return KEY_ARBITRUMGOERLI
	return "UNKNOWN"

func get_chain_name(chain: int):
	match chain:
		Chain.Ethereum: return "Ethereum"
		Chain.EthereumTest: return "Ethereum Goerli"
		Chain.Polygon: return "Polygon"
		Chain.PolygonTest: return "Polygon Mumbai"
		Chain.Arbitrum: return "Arbitrum"
		Chain.ArbitrumTest: return "Arbitrum Goerli"
	return "unknown"


"""
	Contracts API
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

func get_currencies(call_object: Object, call_function: String, game_pub_key: String) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.get_currencies(game_pub_key)
	return ERROR_CALL_OBJECT

func get_currency_balance(call_object: Object, call_function: String, currency_id: String, wallet: String, id: bool = true) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.get_currency_balance(currency_id, wallet, id)
	return ERROR_CALL_OBJECT

func create_currency(call_object: Object, call_function: String, secret_key: String, secret_password: String, chain: int, name: String, symbol: String, supply_cap: String) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.create_currency(secret_key, secret_password, get_chain_key(chain), name, symbol, supply_cap)
	return ERROR_CALL_OBJECT


func mint_currency(call_object: Object, call_function: String, account_token: String, account_password: String, currency_id: String, wallet: String, amount: float, id: bool = true) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.mint_currency(account_token, account_password, currency_id, wallet, amount, id)
	return ERROR_CALL_OBJECT

func burn_currency(call_object: Object, call_function: String, account_token: String, account_password: String, currency_id: String, amount: float) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.burn_currency(account_token, account_password, currency_id, amount)
	return ERROR_CALL_OBJECT


func get_currency_fees(call_object: Object, call_function: String, currency_id: String) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.get_currency_fees(currency_id)
	return ERROR_CALL_OBJECT

func set_currency_fees(call_object: Object, call_function: String, secret_key: String, secret_password: String, currency_id: String, recipient: String, cap_ammount: float, fixed_amount: float, basis_points: int) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.set_currency_fees(secret_key, secret_password, currency_id, recipient, cap_ammount, fixed_amount, basis_points)
	return ERROR_CALL_OBJECT


func get_currency_role(call_object: Object, call_function: String, currency_id: String, wallet: String, role: String, id: bool = true) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.get_currency_role(currency_id, wallet, role, id)
	return ERROR_CALL_OBJECT

func grant_currency_role(call_object: Object, call_function: String, account_token: String, account_password: String, currency_id: String, wallet: String, role: String, id: bool = true) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.grant_currency_role(account_token, account_password, currency_id, wallet, role, id)
	return ERROR_CALL_OBJECT

func revoke_currency_role(call_object: Object, call_function: String, account_token: String, account_password: String, currency_id: String, wallet: String, role: String, id: bool = true) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.revoke_currency_role(account_token, account_password, currency_id, wallet, role, id)
	return ERROR_CALL_OBJECT


func transfer_currency(call_object: Object, call_function: String, account_token: String, account_password: String, currency_id: String, recipient: String, reference: int, amount: float, id: bool = true) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.transfer_currency(account_token, account_password, currency_id, recipient, reference, amount, id)
	return ERROR_CALL_OBJECT

func batch_transfer_currency(call_object: Object, call_function: String, account_token: String, account_password: String, currency_id: String, recipients: Array, references: Array, amounts: Array, id: bool = true) -> String:
	var req = self._currencies_api_init(call_object, call_function)
	if req != null: return req.batch_transfer_currency(account_token, account_password, currency_id, recipients, references, amounts, id)
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

func get_collections(call_object: Object, call_function: String, public_key: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.get_collections(public_key)
	return ERROR_CALL_OBJECT

func get_collection_item(call_object: Object, call_function: String, collection_id: String, item_id: int) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.get_collection_item(collection_id, item_id)
	return ERROR_CALL_OBJECT

func get_collection_items(call_object: Object, call_function: String, collection_id: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.get_collection_items(collection_id)
	return ERROR_CALL_OBJECT


func create_collection(call_object: Object, call_function: String, secret_key: String, password: String, chain: int) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.create_collection(secret_key, password, get_chain_key(chain))
	return ERROR_CALL_OBJECT

func create_collection_item(
	call_object: Object, call_function: String, account_token: String, account_password: String, collection_id: String, item_id: int, 
	name: String, descr: String, image_url: String, image_data: String, extrern_url: String, data: Dictionary, attribs: Array
) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.create_collection_item(
		account_token, account_password, collection_id, item_id, 
		name, descr, image_url, image_data, extrern_url, data, attribs
	)
	return ERROR_CALL_OBJECT


func get_collection_item_supply(call_object: Object, call_function: String, collection_id: String, item_id: int, wallet: String, id: bool = true) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.get_collection_item_supply(collection_id, item_id, wallet, id)
	return ERROR_CALL_OBJECT

func get_collection_item_balance(call_object: Object, call_function: String, collection_id: String, item_id: int, wallet: String, id: bool = true) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.get_collection_item_balance(collection_id, item_id, wallet, id)
	return ERROR_CALL_OBJECT

func get_collection_item_supplies(call_object: Object, call_function: String, collection_id: String) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.get_collection_item_supplies(collection_id)
	return ERROR_CALL_OBJECT

func get_collection_item_balances(call_object: Object, call_function: String, collection_id: String, wallet: String, id: bool = true) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.get_collection_item_balances(collection_id, wallet, id)
	return ERROR_CALL_OBJECT


func get_collection_role(call_object: Object, call_function: String, collection_id: String, role: String, wallet: String, id: bool = true) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.get_collection_role(collection_id, role, wallet, id)
	return ERROR_CALL_OBJECT

func grant_collection_role(call_object: Object, call_function: String, account_token: String, account_password: String, collection_id: String, role: String, wallet: String, id: bool = true) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.grant_collection_role(account_token, account_password, collection_id, role, wallet, id)
	return ERROR_CALL_OBJECT

func revoke_collection_role(call_object: Object, call_function: String, account_token: String, account_password: String, collection_id: String, role: String, wallet: String, id: bool = true) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.revoke_collection_role(account_token, account_password, collection_id, role, wallet, id)
	return ERROR_CALL_OBJECT


func get_collection_approval(call_object: Object, call_function: String, collection_id: String, opperator: String, wallet: String, id: bool = true) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.get_collection_approval(collection_id, opperator, wallet, id)
	return ERROR_CALL_OBJECT

func set_collection_approval(call_object: Object, call_function: String, account_token: String, account_password: String, collection_id: String, opperator: String, approved: bool) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.set_collection_approval(account_token, account_password, collection_id, opperator, approved)
	return ERROR_CALL_OBJECT


func burn_collection_item(call_object: Object, call_function: String, account_token: String, account_password: String, collection_id: String, item_id: int, amount: int) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.burn_collection_item(account_token, account_password, collection_id, item_id, amount)
	return ERROR_CALL_OBJECT

func mint_collection_item(call_object: Object, call_function: String, account_token: String, account_password: String, collection_id: String, item_id: int, amount: int, reciever: String, id: bool = true) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.mint_collection_item(account_token, account_password, collection_id, item_id, amount, reciever, id)
	return ERROR_CALL_OBJECT

func batch_mint_collection_items(call_object: Object, call_function: String, account_token: String, account_password: String, collection_id: String, item_ids: Array, amounts: Array, reciever: String, id: bool = true) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.batch_mint_collection_items(account_token, account_password, collection_id, item_ids, amounts, reciever, id)
	return ERROR_CALL_OBJECT

func transfer_collection_item(call_object: Object, call_function: String, account_token: String, account_password: String, collection_id: String, item_id: int, amount: int, reciever: String, id: bool = true) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.transfer_collection_item(account_token, account_password, collection_id, item_id, amount, reciever, id)
	return ERROR_CALL_OBJECT

func batch_transfer_collection_items(call_object: Object, call_function: String, account_token: String, account_password: String, collection_id: String, item_ids: Array, amounts: Array, recievers: Array, id: bool = true) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.batch_transfer_collection_items(account_token, account_password, collection_id, item_ids, amounts, recievers, id)
	return ERROR_CALL_OBJECT

func get_collection_item_timelock(call_object: Object, call_function: String, collection_id: String, item_id: int) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.get_collection_item_timelock(collection_id, item_id)
	return ERROR_CALL_OBJECT

func set_collection_item_timelock(call_object: Object, call_function: String, account_token: String, account_password: String, collection_id: String, item_ids: int, timelock: int) -> String:
	var req = self._items_api_init(call_object, call_function)
	if req != null: return req.set_collection_item_timelock(account_token, account_password, collection_id, item_ids, timelock)
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

func get_transaction(call_object: Object, call_function: String, transaction_id: String) -> String:
	var req = self._transactions_api_init(call_object, call_function)
	if req != null: return req.get_transaction(transaction_id)
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

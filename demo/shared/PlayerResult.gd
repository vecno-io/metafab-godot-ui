extends Container

onready var _name = get_node("%NameField")
onready var _created_at = get_node("%CreatedAtField")
onready var _updated_at = get_node("%UpdatedAtField")
onready var _game_id = get_node("%GameIdField")
onready var _player_id = get_node("%PlayerIdField")
onready var _access_key = get_node("%AccessKeyField")

onready var _wallet_id = get_node("%WalletIdField")
onready var _wallet_acc = get_node("%WalletAccField")

func hide():
	self.visible = false

func clear():
	_name.text = ""
	_created_at.text = ""
	_updated_at.text = ""
	_game_id.text = ""
	_player_id.text = ""
	_access_key.text = ""
	_wallet_id.text = ""
	_wallet_acc.text = ""

func show_result(name: String, data: Dictionary):
	print("[%s] result: %s" % [name, data])
	if data.has("username"): 
		_name.text = data.username
	if data.has("createdAt"): 
		_created_at.text = data.createdAt
	if data.has("updatedAt"):
		_updated_at.text = data.updatedAt
	if data.has("gameId"):
		_game_id.text = data.gameId
	if data.has("id"):
		_player_id.text = data.id
	if data.has("accessToken"):
		_access_key.text = data.accessToken
	if data.has("wallet"):
		if data.wallet.has("id"):
			_wallet_id.text = data.wallet.id
		if data.wallet.has("address"):
			_wallet_acc.text = data.wallet.address
	self.visible = true

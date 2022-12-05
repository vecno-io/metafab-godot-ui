extends Container

onready var _name = get_node("%NameField")
onready var _game_id = get_node("%GameIdField")
onready var _created_at = get_node("%CreatedAtField")
onready var _updated_at = get_node("%UpdatedAtField")
onready var _secret_key = get_node("%SecretKeyField")
onready var _published_key = get_node("%PublishedKeyField")

onready var _wallet_id = get_node("%WalletIdField")
onready var _wallet_acc = get_node("%WalletAccField")

onready var _funding_id = get_node("%FundingIdField")
onready var _funding_acc = get_node("%FundingAccField")

func hide():
	self.visible = false

func clear():
	_name.text = ""
	_game_id.text = ""
	_created_at.text = ""
	_updated_at.text = ""
	_secret_key.text = ""
	_published_key.text = ""
	_wallet_id.text = ""
	_wallet_acc.text = ""
	_funding_id.text = ""
	_funding_acc.text = ""

func show_result(name: String, data: Dictionary):
	print("[%s] result: %s" % [name, data])
	if data.has("id"):
		_game_id.text = data.id
	if data.has("name"): 
		_name.text = data.name
	if data.has("createdAt"): 
		_created_at.text = data.createdAt
	if data.has("updatedAt"):
		_updated_at.text = data.updatedAt
	if data.has("secretKey"):
		_secret_key.text = data.secretKey
	if data.has("publishedKey"):
		_published_key.text = data.publishedKey
	if data.has("wallet"):
		if data.wallet.has("id"):
			_wallet_id.text = data.wallet.id
		if data.wallet.has("address"):
			_wallet_acc.text = data.wallet.address
	if data.has("fundingWallet"):
		if data.fundingWallet.has("id"):
			_funding_id.text = data.fundingWallet.id
		if data.fundingWallet.has("address"):
			_funding_acc.text = data.fundingWallet.address
	self.visible = true
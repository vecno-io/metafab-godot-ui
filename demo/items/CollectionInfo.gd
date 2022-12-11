extends Container

signal select(id)

var chain = 0

onready var _chain_field = get_node("%ChainField")
onready var _object_field = get_node("%ObjectField")
onready var _address_field = get_node("%AddressField")

onready var _select_button = get_node("%SelectButton")

func _ready():
	_select_button.connect("pressed", self, "_on_select_pressed")

func _on_select_pressed():
	emit_signal("select", _object_field.text)

func set_info(data: Dictionary):
	_object_field = get_node("%ObjectField")
	if !data.has("id"): _object_field.text = ""
	else: _object_field.text = data["id"]
	if data.has("contract"): 
		_set_contract(data["contract"])

func _set_contract(contract: Dictionary):
	_address_field = get_node("%AddressField")
	if !contract.has("address"): _address_field.text = ""
	else: _address_field.text = contract["address"]
	_chain_field = get_node("%ChainField")
	if !contract.has("chain"): self.chain = 0
	else: self.chain = MetaFab.get_chain_id(contract["chain"])
	_chain_field.text = MetaFab.get_chain_name(self.chain)

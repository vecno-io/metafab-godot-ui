extends GridContainer

signal select(id)

var _data: Dictionary = {}

onready var _name = get_node("%NameField")
onready var _symbol = get_node("%SymbolField")
onready var _asset_id = get_node("%AssetIdField")

onready var _select_button = get_node("%SelectButton")

func _ready():
	_select_button.connect("pressed", self, "_on_select_pressed")

func _on_select_pressed():
	emit_signal("select", _data)

func set_info(data: Dictionary):
	self._data = data
	_name = get_node("%NameField")
	if !data.has("name"): _name.text = ""
	else: _name.text = data["name"]
	_symbol = get_node("%SymbolField")
	if !data.has("symbol"): _symbol.text = ""
	else: _symbol.text = data["symbol"]
	_asset_id = get_node("%AssetIdField")
	if !data.has("id"): _asset_id.text = ""
	else: _asset_id.text = data["id"]

class_name ChainSelect
extends OptionButton

const DEFAULT_CHAIN = 2

signal chain_selected(id)

var chain setget _set_chain, _get_chain

func _ready():
	self.add_item(MetaFab.get_chain_name(MetaFab.Chain.Ethereum))
	self.add_item(MetaFab.get_chain_name(MetaFab.Chain.EthereumTest))
	self.add_item(MetaFab.get_chain_name(MetaFab.Chain.Polygon))
	self.add_item(MetaFab.get_chain_name(MetaFab.Chain.PolygonTest))
	self.add_item(MetaFab.get_chain_name(MetaFab.Chain.Arbitrum))
	self.add_item(MetaFab.get_chain_name(MetaFab.Chain.ArbitrumTest))
	var _x = connect("item_selected", self, "_on_item_selected")
	self.selected = DEFAULT_CHAIN

func _get_chain() -> int:
	return self.selected + 1

func _set_chain(val: int):
	self.selected = int(clamp(val, 0, 5))

func _on_item_selected(value: int):
	emit_signal("chain_selected", value + 1)

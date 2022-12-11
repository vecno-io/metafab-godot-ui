extends Container

#onready var txn_info = get_node("%TxnInfo")

onready var txn_info_box = get_node("%TxnInfo")

onready var items_box = get_node("%ItemsBox")
onready var items_list = get_node("%ItemsList")

onready var collection_box = get_node("%CollectionBox")
onready var collection_list = get_node("%CollectionList")

onready var password_input = get_node("%PasswordInput")
onready var publickey_input = get_node("%PublicKeyInput")
onready var secretkey_input = get_node("%SecretKeyInput")
onready var collection_field = get_node("%CollectionField")

onready var id_field = get_node("%IdField")
onready var name_field = get_node("%NameField")
onready var descr_field = get_node("%DescrField")
onready var data_url_field = get_node("%DataUrlField")
onready var image_url_field = get_node("%ImageUrlField")

onready var wallet_input = get_node("%WalletInput")
onready var quantity_input = get_node("%QuantityInput")

onready var mint_item_button = get_node("%MintItemButton")
onready var get_collections_button = get_node("%GetCollectionsButton")
onready var get_collections_items_button = get_node("%GetCollectionItemsButton")

var ItemInfo = preload("res://demo/items/ItemInfo.tscn")
var CollectionInfo = preload("res://demo/items/CollectionInfo.tscn")

func _ready():
	quantity_input.connect("focus_exited", self, "_on_quantity_exit")
	mint_item_button.connect("pressed", self, "_on_mint_item_pressed")
	get_collections_button.connect("pressed", self, "_on_get_collections_pressed")
	get_collections_items_button.connect("pressed", self, "_on_get_collection_items_pressed")

func _on_quantity_exit():
	quantity_input.text = "%s" % quantity_input.text.to_int()


func _on_mint_item_pressed():
	print("[%s] _on_mint_item_pressed" % [name])
	var res = MetaFab.mint_collection_item(self, "_on_mint_item_result",
		secretkey_input.text, password_input.text, collection_field.text, 
		id_field.text.to_int(), quantity_input.text.to_int(), wallet_input.text
	)
	if res == MetaFabRequest.Ok: self._clear_lists()
	else: txn_info_box.show_error(name, -1, res)

func _on_mint_item_result(code: int, result: String):
	var json = JSON.parse(result)
	if code == 200: txn_info_box.show_data(json.result)
	else: self._show_error(code, result)
	
func _on_get_collections_pressed():
	print("[%s] _on_get_collections_pressed" % [name])
	var res = MetaFab.get_collections(self, "_on_get_collections_result", publickey_input.text)
	if res == MetaFabRequest.Ok: self._clear_lists()
	else: txn_info_box.show_error(name, -1, res)

func _on_get_collections_result(code: int, result: String):
	var json = JSON.parse(result)
	if code == 200: self._show_collection_list(json.result)
	else: self._show_error(code, result)


func _on_get_collection_items_pressed():
	print("[%s] _on_get_collection_items_pressed" % [name])
	var res = MetaFab.get_collection_items(self, "_on_get_collection_items_result", collection_field.text)
	if res == MetaFabRequest.Ok: self._clear_lists()
	else: txn_info_box.show_error(name, -1, res)

func _on_get_collection_items_result(code: int, result: String):
	var json = JSON.parse(result)
	if code == 200: self._show_items_list(json.result)
	else: self._show_error(code, result)


func _clear_lists():
	txn_info_box.clear()
	items_box.visible = false
	collection_box.visible = false
	for item in items_list.get_children():
		item.queue_free()
	for item in collection_list.get_children():
		item.queue_free()

func _show_error(code: int, message: String):
	items_box.visible = false
	collection_box.visible = false
	txn_info_box.show_error(name, code, message)


func _show_items_list(array: Array):
	txn_info_box.clear()
	collection_box.visible = false
	for data in array:
		var item = ItemInfo.instance()
		item.connect("select", self, "_on_select_item")
		items_list.add_child(item)
		item.set_info(data)
	items_box.visible = true

func _show_collection_list(array: Array):
	txn_info_box.clear()
	items_box.visible = false
	for data in array:
		var item = CollectionInfo.instance()
		item.connect("select", self, "_on_select_collection")
		collection_list.add_child(item)
		item.set_info(data)
	collection_box.visible = true


func _on_select_item(item_data: Dictionary):
	if !item_data.has("id"): id_field.text = ""
	else: id_field.text = "%s" % item_data["id"]
	if !item_data.has("name"): name_field.text = ""
	else: name_field.text = item_data["name"]
	if !item_data.has("description"): descr_field.text = ""
	else: descr_field.text = item_data["description"]
	if !item_data.has("externalUrl"): data_url_field.text = ""
	else: data_url_field.text = item_data["externalUrl"]
	if !item_data.has("image"): image_url_field.text = ""
	else: image_url_field.text = item_data["image"]


func _on_select_collection(collection_id: String):
	collection_field.text = collection_id

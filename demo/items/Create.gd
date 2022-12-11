extends Container

var attribs_data = []
var extra_data = {}

onready var txn_box = get_node("%TxnInfo")
onready var collection_box = get_node("%CollectionBox")
onready var collection_list = get_node("%CollectionList")

onready var chain_select = get_node("%ChainSelect")
onready var password_input = get_node("%PasswordInput")
onready var publickey_input = get_node("%PublicKeyInput")
onready var secretkey_input = get_node("%SecretKeyInput")
onready var collection_input = get_node("%CollectionInput")

onready var get_collection_button = get_node("%GetCollectionsButton")
onready var create_collection_button = get_node("%CreateCollectionButton")
onready var create_collection_button_item = get_node("%CreateCollectionButtonItem")

onready var id_input = get_node("%IdInput")
onready var name_input = get_node("%NameInput")
onready var descr_input = get_node("%DescrInput")
onready var data_url_input = get_node("%DataUrlInput")
onready var image_url_input = get_node("%ImageUrlInput")
onready var image_data_input = get_node("%ImageDataInput")

onready var attribs_input = get_node("%AttribsInput")
onready var metadata_input = get_node("%MetadataInput")

onready var attribs_dialog = get_node("%AttribsDialog")
onready var metadata_dialog = get_node("%MetadataDialog")

onready var edit_atribs_button = get_node("%EditAtribsButton")
onready var edit_metadata_button = get_node("%EditMetadataButton")

var CollectionInfo = preload("res://demo/items/CollectionInfo.tscn")

func _ready():
	id_input.connect("focus_exited", self, "_on_id_exit")
	attribs_dialog.connect("save_data", self, "_on_save_attribs")
	metadata_dialog.connect("save_data", self, "_on_save_metadata")
	edit_atribs_button.connect("pressed", self, "_on_edit_atribs_pressed")
	edit_metadata_button.connect("pressed", self, "_on_edit_metadata_pressed")
	get_collection_button.connect("pressed", self, "_on_get_collections")
	create_collection_button.connect("pressed", self, "_on_create_collection")
	create_collection_button_item.connect("pressed", self, "_on_create_collection_item")


func _on_id_exit():
	id_input.text = "%s" % id_input.text.to_int()

func _on_save_attribs(data: Array):
	attribs_input.text = to_json(data)
	attribs_data = data

func _on_save_metadata(data: Dictionary):
	metadata_input.text = to_json(data)
	extra_data = data


func _on_edit_atribs_pressed():
	attribs_dialog.popup_centered()

func _on_edit_metadata_pressed():
	metadata_dialog.popup_centered()


func _on_get_collections():
	print("[%s] _on_get_collections_pressed" % [name])
	var res = MetaFab.get_collections(self, "_on_get_collections_result", publickey_input.text)
	if res == MetaFabRequest.Ok: self._clear_collection_list()
	else: txn_box.show_error(name, -1, res)

func _on_get_collections_result(code: int, result: String):
	var json = JSON.parse(result)
	if code == 200: self._show_collection_list(json.result)
	else: self._show_collection_error(code, json.result)


func _on_create_collection():
	print("[%s] _on_create_collection" % [name])
	var res = MetaFab.create_collection(self, "_on_create_collection_result", 
		secretkey_input.text, password_input.text, chain_select.chain
	)
	if res == MetaFabRequest.Ok: self._clear_collection_list()
	else: txn_box.show_error(name, -1, res)

func _on_create_collection_result(code: int, result: String):
	var json = JSON.parse(result)
	if code == 200: self._on_get_collections()
	else: self._show_collection_error(code, json.result)

func _on_create_collection_item():
	print("[%s] _on_create_collection_item" % [name])
	var res = MetaFab.create_collection_item(self, "_on_create_collection_item_result", 
		secretkey_input.text, password_input.text, collection_input.text, id_input.text.to_int(), 
		name_input.text, descr_input.text, data_url_input.text, 
		image_url_input.text, image_data_input.text, 
		extra_data, attribs_data
	)
	if res == MetaFabRequest.Ok: self._clear_collection_list()
	else: txn_box.show_error(name, -1, res)

func _on_create_collection_item_result(code: int, result: String):
	var json = JSON.parse(result)
	if code == 200: self.txn_box.clear()
	else: self.txn_box.show_error(name, code, json.result)


func _clear_collection_list():
	txn_box.clear()
	collection_box.visible = false
	for item in collection_list.get_children():
		item.queue_free()

func _show_collection_list(array: Array):
	for data in array:
		var item = CollectionInfo.instance()
		item.connect("select", self, "_on_select_collection")
		collection_list.add_child(item)
		item.set_info(data)
	collection_box.visible = true


func _on_select_collection(collection_id: String):
	collection_input.text = collection_id

func _show_collection_error(code: int, message: String):
	collection_box.visible = false
	txn_box.show_error(name, code, message)

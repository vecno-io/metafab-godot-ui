tool
extends EditorPlugin

func _enter_tree():
	add_autoload_singleton("MetaFab", "res://addons/metafab-api/MetaFab.tscn")


func _exit_tree():
	remove_autoload_singleton("MetaFab")

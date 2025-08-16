@tool
extends EditorContextMenuPlugin

var window_path = "res://addons/FIGlet2Godot/window.tscn"
var window
var window_open : bool = false


func _popup_menu(paths: PackedStringArray) -> void:
	add_context_menu_item("FIGlet", open_window)


func open_window(_what : Variant = ""):
	if window_open: return
	window = load(window_path).instantiate()
	EditorInterface.get_base_control().add_child(window)
	window_open = true
	window.popup_centered()
	window.close_requested.connect(close_window)

func close_window():
	window_open = false
	window.queue_free()

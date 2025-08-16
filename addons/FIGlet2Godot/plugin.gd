@tool
extends EditorPlugin

const ContextFilepath : String = "res://addons/FIGlet2Godot/context.gd"
var context := EditorContextMenuPlugin.new()

func _enter_tree() -> void:
	add_context_menu_plugin(EditorContextMenuPlugin.CONTEXT_SLOT_SCRIPT_EDITOR_CODE, context)

func _exit_tree() -> void:
	remove_context_menu_plugin(context)

func _ready():
	context.set_script(load(ContextFilepath))

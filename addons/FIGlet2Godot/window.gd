@tool
extends Window

#                                            ░██                                       
#                                            ░██                                       
# ░█████████████   ░███████  ░█████████████  ░████████   ░███████  ░██░████  ░███████  
# ░██   ░██   ░██ ░██    ░██ ░██   ░██   ░██ ░██    ░██ ░██    ░██ ░███     ░██        
# ░██   ░██   ░██ ░█████████ ░██   ░██   ░██ ░██    ░██ ░█████████ ░██       ░███████  
# ░██   ░██   ░██ ░██        ░██   ░██   ░██ ░███   ░██ ░██        ░██             ░██ 
# ░██   ░██   ░██  ░███████  ░██   ░██   ░██ ░██░█████   ░███████  ░██       ░███████  


enum FigletExec { Linux, Windows, PyLinux, PyWindows, Custom }
var figletexec_enum : int = FigletExec.Linux

enum FontGetMethod { Dir, Tag, Disable }
var fontgetmethod_enum : int = FontGetMethod.Dir

enum BlankCull { None, End, StartEnd, All }
var blankcull_enum : int = BlankCull.End

var figlet_exec : String = "figlet"
var figlet_tags : Array = ["-f", "Terrace", "-w 100"] #TODO: empty this later
var custom_tags : String = ""
var figlet_font_dir : String = ""
var comment_prefix : String = "# "

var input_text : String = ""
var await_text : String = ""

#                               ░██    ░██                          ░██            
#                               ░██    ░██                          ░██            
# ░█████████████   ░███████  ░████████ ░████████   ░███████   ░████████  ░███████  
# ░██   ░██   ░██ ░██    ░██    ░██    ░██    ░██ ░██    ░██ ░██    ░██ ░██        
# ░██   ░██   ░██ ░█████████    ░██    ░██    ░██ ░██    ░██ ░██    ░██  ░███████  
# ░██   ░██   ░██ ░██           ░██    ░██    ░██ ░██    ░██ ░██   ░███        ░██ 
# ░██   ░██   ░██  ░███████      ░████ ░██    ░██  ░███████   ░█████░██  ░███████  


func _ready():
	create_preview()


# ░██████████░██████  ░██████  ░██               ░██       ░██████████           ░██        
# ░██          ░██   ░██   ░██ ░██               ░██           ░██               ░██        
# ░██          ░██  ░██        ░██  ░███████  ░████████        ░██     ░██████   ░████████  
# ░█████████   ░██  ░██  █████ ░██ ░██    ░██    ░██           ░██          ░██  ░██    ░██ 
# ░██          ░██  ░██     ██ ░██ ░█████████    ░██           ░██     ░███████  ░██    ░██ 
# ░██          ░██   ░██  ░███ ░██ ░██           ░██           ░██    ░██   ░██  ░███   ░██ 
# ░██        ░██████  ░█████░█ ░██  ░███████      ░████        ░██     ░█████░██ ░██░█████  


#region || FIGlet Tab #TODO: Once we have the config tab ready we will undoubtedly have to rewrite this, but it works at the moment.


func write_to_window():
	input_text = await_text
	build_tags()
	var tags : Array = [input_text]
	for i in figlet_tags: tags.append(i)
	
	var out : Array = []
	var exit_code = OS.execute(figlet_exec, tags, out)
	#var exit_code = OS.execute(figlet_exec, [figlet_input, "-f Terrace"], out) #intentionally-wrong setup, for testing
	if exit_code == -1:
		%Output.text = '''ERROR: exit_code == -1. Could not run FIGlet. Make sure FIGlet or pyFIGlet are actually installed, and make sure the executable is set for the appropriate version of FIGlet you are using.'''
	
	elif exit_code == 1:
		%Output.text = '''ERROR: exit_code == 1. Something isn't right, either with the FIGlet commands/tags or with your computer setup. Steps to take:
		1. Make sure you have the correct FIGlet executable. For example if you are on Windows and using pyfiglet, the executable should be \"pyfiglet\".
		2. If you are trying to input custom tags, make sure they're set up correctly. Remember: while both "-w, <width>" and "-w <width>" work fine, "-f <fontname>" does NOT work, yet "-f,<fontname>" does -- for some reason!
			2a. Don't rule out blaming me! lol. Feel free to look at the plugin's scripts.
		3. Reset your project.
		4. Reset your computer.
		5. Reinstall your version of figlet.
		6. If you are using pyfiglet, try reinstalling or updating Python, and make sure pip works.'''
	
	elif exit_code == 0:
		#%Output.text = r"%s" % out
		%Output.text = cull_blanks( r"%s" % out )
	
	else:
		print("UNKNOWN ERROR: I only know what the exit codes -1, 1, and 0 mean. You got the exit code %s." % str(exit_code))



func _on_cull_empty_item_selected(index: int) -> void:
	blankcull_enum = index
	write_to_window()



func cull_blanks(_text : String) -> String:
	if blankcull_enum == BlankCull.None: return _text
	var out : String = ""
	var work : PackedStringArray = _text.split("\n")
	var culled : PackedStringArray
	match blankcull_enum:
		
		BlankCull.End:
			var lastline : int = -1
			for i in range(work.size()-1, -1, -1):
				if work[i].dedent() != "":
					lastline = i
					break
			culled = work.slice(0,lastline+1)
		
		BlankCull.StartEnd:
			var firstline : int = 0
			for i in work.size():
				if work[i].dedent() != "":
					firstline = i
					break
			var lastline : int = -1
			for i in range(work.size()-1, -1, -1):
				if work[i].dedent() != "":
					lastline = i
					break
			culled = work.slice(firstline,lastline+1)
		
		BlankCull.All:
			culled = work
			for i in range(culled.size()-1,-1,-1):
				if culled[i].dedent() == "":
					culled.remove_at(i)
	
	for i in culled:
		out += "%s\n" % i
	out = out.trim_suffix("\n")
	return out



func format_as_comment() -> String:
	var work : PackedStringArray = %Output.text.split("\n")
	var out : String = ""
	for i in work:
		if !i.begins_with("#"):
			if !i.begins_with("# "):
				out += "%s%s\n" % [comment_prefix, i]
			else:
				i.trim_prefix("#")
				out += "%s%s\n" % [comment_prefix, i]
		else:
			out += "%s\n" % i
	out.trim_suffix("\n")
	return out



func _on_update_timer_timeout() -> void:
	if input_text != await_text:
		write_to_window()



func _on_input_text_changed(new_text: String) -> void:
	await_text = new_text



func _on_copy_comment_pressed() -> void:
	write_to_window() # forces update before anything
	%Output.text = format_as_comment()
	%Output.select_all()
	%Output.copy()



func _on_copy_pressed() -> void:
	write_to_window() # forces update before anything
	%Output.select_all()
	%Output.copy()



func _on_force_update_pressed() -> void:
	write_to_window()


#endregion || /FIGlet Tab


#   ░██████                            ░████ ░██              ░██████████           ░██        
#  ░██   ░██                          ░██                         ░██               ░██        
# ░██         ░███████  ░████████  ░████████ ░██ ░████████        ░██     ░██████   ░████████  
# ░██        ░██    ░██ ░██    ░██    ░██    ░██░██    ░██        ░██          ░██  ░██    ░██ 
# ░██        ░██    ░██ ░██    ░██    ░██    ░██░██    ░██        ░██     ░███████  ░██    ░██ 
#  ░██   ░██ ░██    ░██ ░██    ░██    ░██    ░██░██   ░███        ░██    ░██   ░██  ░███   ░██ 
#   ░██████   ░███████  ░██    ░██    ░██    ░██ ░█████░██        ░██     ░█████░██ ░██░█████  
#                                                      ░██                                     
#                                                ░███████                                      
#region || Configuration Tab


# Config Tab:
#         ░███     ░███            ░██              ░████████                     ░██            
# ░██     ░████   ░████                             ░██    ░██                    ░██            
#  ░██    ░██░██ ░██░██  ░██████   ░██░████████     ░██    ░██   ░███████   ░████████ ░██    ░██ 
#   ░██   ░██ ░████ ░██       ░██  ░██░██    ░██    ░████████   ░██    ░██ ░██    ░██ ░██    ░██ 
#  ░██    ░██  ░██  ░██  ░███████  ░██░██    ░██    ░██     ░██ ░██    ░██ ░██    ░██ ░██    ░██ 
# ░██     ░██       ░██ ░██   ░██  ░██░██    ░██    ░██     ░██ ░██    ░██ ░██   ░███ ░██   ░███ 
#         ░██       ░██  ░█████░██ ░██░██    ░██    ░█████████   ░███████   ░█████░██  ░█████░██ 
#                                                                                            ░██ 
#                                                                                      ░███████  
#region || Configuration Tab >> Main Body


func create_preview():
	build_tags()
	var out = []
	var _tags = ["AaBbCc"]
	for i in figlet_tags: _tags.append(i)
	OS.execute(figlet_exec, _tags, out)
	%Demo.text = r"%s" % out



func populate_fonts_by_dir():
	%FontList.clear()
	var out : Array
	var exit_code : int = OS.execute(figlet_exec, ["-I 2"], out)
	if exit_code == 0:
		var dirpath : String = out[0].strip_edges()
		var dir = DirAccess.open(dirpath)
		var filelist : PackedStringArray = dir.get_files()
		for i in range(filelist.size()-1, -1, -1):
			if !filelist[i].ends_with("flf") and !filelist[i].ends_with("flc"):
				filelist.remove_at(i)
			else:
				filelist[i] = filelist[i].trim_suffix(".flf").trim_suffix(".flc").strip_edges()
		filelist.sort()
		for i in filelist:
			%FontList.add_item(i)
	
	else:
		print("Could not populate font list.")
	
	if %FontList.get_item_text(0) == "":
		print("Font list is empty. Likely culprit: incorrect settings.")



func populate_fonts_by_tag():
	%FontList.clear()
	var out : Array
	var exit_code = OS.execute(figlet_exec, ["-l"], out)
	if exit_code == 0:
		var work = "%s" % out
		var split = work.split("\n")
		var filelist : Array[String]
		for i in split:
			filelist.append(i.strip_edges())
		for i in filelist:
			%FontList.add_item(i)
		
	else:
		print("Could not populate font list.")
	
	if %FontList.get_item_text(0) == "":
		print("Font list is empty. Likely culprit: incorrect settings.")



func _on_change_font_toggled(toggled_on: bool) -> void:
	if !toggled_on:
		%FontList.deselect_all()
	build_tags()



func _on_font_list_item_selected(index: int) -> void:
	if !%ChangeFont.button_pressed:
		%FontList.deselect_all()
	else:
		build_tags()
		create_preview()



func build_tags():
	var tags : Array
	figlet_tags.clear()
	
	if %CustomTags.button_pressed:
		var split = custom_tags.split(",",false)
		for i in split:
			figlet_tags.append(i)
	
	else:
		if %ChangeFont.button_pressed:
			var fontlist_selection = %FontList.get_selected_items()
			if fontlist_selection.size() > 0:
				var _font = %FontList.get_item_text( %FontList.get_selected_items()[0] )
				if _font != "":
					tags.append("-f")
					tags.append(_font)
		if %WidthTag.button_pressed:
			tags.append("-w %s" % str(%CharWidth.value))
		figlet_tags = tags.duplicate()


#endregion || /Main Body


# Config Tab:
#           ░██████                 ░██                             ░██████████           ░██        
# ░██      ░██   ░██                ░██                                 ░██               ░██        
#  ░██    ░██          ░███████  ░████████ ░██    ░██ ░████████         ░██     ░██████   ░████████  
#   ░██    ░████████  ░██    ░██    ░██    ░██    ░██ ░██    ░██        ░██          ░██  ░██    ░██ 
#  ░██            ░██ ░█████████    ░██    ░██    ░██ ░██    ░██        ░██     ░███████  ░██    ░██ 
# ░██      ░██   ░██  ░██           ░██    ░██   ░███ ░███   ░██        ░██    ░██   ░██  ░███   ░██ 
#           ░██████    ░███████      ░████  ░█████░██ ░██░█████         ░██     ░█████░██ ░██░█████  
#                                                     ░██                                            
#                                                     ░██                                            
#region || Configuration Tab >> Setup Tab


func pull_font_dir() -> String:
	if figletexec_enum > 1: return ""
	var work : Array = []
	OS.execute(figlet_exec, ["-I 2"], work)
	var out : String = "%s" % work
	out = out.strip_edges()
	return out


func _on_exec_item_selected(index: int) -> void:
	%ExecCustom.editable = false
	figletexec_enum = index
	
	match index:
		FigletExec.Linux:
			figlet_exec = "figlet"
			figlet_font_dir = pull_font_dir()
			%OpenFontFolder.disabled = false
			%GetFontMethod.select(FontGetMethod.Dir)
		FigletExec.Windows:
			figlet_exec = "figlet"
			figlet_font_dir = pull_font_dir()
			%OpenFontFolder.disabled = false
			%GetFontMethod.select(FontGetMethod.Dir)
		FigletExec.PyLinux:
			figlet_exec = "pyfiglet"
			figlet_font_dir = ""
			%OpenFontFolder.disabled = true
			%GetFontMethod.select(FontGetMethod.Tag)
		FigletExec.PyWindows:
			figlet_exec = "pyfiglet"
			figlet_font_dir = ""
			%OpenFontFolder.disabled = true
			%GetFontMethod.select(FontGetMethod.Tag)
		FigletExec.Custom:
			%GetFontMethod.select(FontGetMethod.Disable)
			figlet_exec = %ExecCustom.text
			figlet_font_dir = ""
			%OpenFontFolder.disabled = true
			if %ExecCustom.text == "": %ExecCustom.text = "figlet"
			%ExecCustom.editable = true



func _on_exec_custom_text_changed(new_text: String) -> void:
	figlet_exec = new_text



func _on_get_width_pressed() -> void:
	pass # Replace with function body.



func get_guideline():
	var editor_settings = EditorInterface.get_editor_settings()
	var guideline = editor_settings.get_setting("text_editor/appearance/guidelines/line_length_guideline_hard_column")
	%WidthTag.value = guideline



func _on_get_font_method_item_selected(index: int) -> void:
	%FontList.deselect_all()
	%ChangeFont.button_pressed = false
	%ChangeFont.disabled = false
	match index:
		FontGetMethod.Dir:
			populate_fonts_by_dir()
		FontGetMethod.Tag:
			populate_fonts_by_tag()
		FontGetMethod.Disable:
			%ChangeFont.disabled = true



func _on_open_font_folder_pressed() -> void:
	if figlet_font_dir == "":
		pull_font_dir()
	if figlet_font_dir != "":
		OS.shell_open(figlet_font_dir)


#endregion || /Setup Tab


# Config Tab:
#           ░██████                           ░██                                  ░██████████           ░██        
# ░██      ░██   ░██                          ░██                                      ░██               ░██        
#  ░██    ░██        ░██    ░██  ░███████  ░████████  ░███████  ░█████████████         ░██     ░██████   ░████████  
#   ░██   ░██        ░██    ░██ ░██           ░██    ░██    ░██ ░██   ░██   ░██        ░██          ░██  ░██    ░██ 
#  ░██    ░██        ░██    ░██  ░███████     ░██    ░██    ░██ ░██   ░██   ░██        ░██     ░███████  ░██    ░██ 
# ░██      ░██   ░██ ░██   ░███        ░██    ░██    ░██    ░██ ░██   ░██   ░██        ░██    ░██   ░██  ░███   ░██ 
#           ░██████   ░█████░██  ░███████      ░████  ░███████  ░██   ░██   ░██        ░██     ░█████░██ ░██░█████  
#region || Configuration Tab >> Customization Tab


func _on_width_tag_toggled(toggled_on: bool) -> void:
	%CharWidth.editable = toggled_on
	build_tags()



func _on_char_width_value_changed(value: float) -> void:
	%Output.line_length_guidelines[0] = int(value)
	build_tags()



func _on_comment_prefix_text_changed(new_text: String) -> void:
	new_text = new_text.replace("\\t", "\t")
	comment_prefix = new_text



func _on_custom_tags_toggled(toggled_on: bool) -> void:
	%TagInput.editable = toggled_on
	if toggled_on:
		_on_tag_input_text_changed(%TagInput.text)



func _on_tag_input_text_changed(new_text: String) -> void:
	if !%CustomTags.button_pressed: return
	custom_tags = new_text
	build_tags()


#endregion || /Customization Tab
#endregion || /Configuration Tab

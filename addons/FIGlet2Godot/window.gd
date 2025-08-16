@tool
extends Window

#                                            ░██                                       
#                                            ░██                                       
# ░█████████████   ░███████  ░█████████████  ░████████   ░███████  ░██░████  ░███████  
# ░██   ░██   ░██ ░██    ░██ ░██   ░██   ░██ ░██    ░██ ░██    ░██ ░███     ░██        
# ░██   ░██   ░██ ░█████████ ░██   ░██   ░██ ░██    ░██ ░█████████ ░██       ░███████  
# ░██   ░██   ░██ ░██        ░██   ░██   ░██ ░███   ░██ ░██        ░██             ░██ 
# ░██   ░██   ░██  ░███████  ░██   ░██   ░██ ░██░█████   ░███████  ░██       ░███████  


enum FigletExec { Linux, Windows, PyFiglet, Custom }
var figletexec_enum = FigletExec.Linux
enum FontGetMethod { Dir, Tag, Disable }
var fontgetmethod_enum = FontGetMethod.Dir

var figlet_exec : String = "figlet"

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
	populate_fonts_by_dir() # TODO: This is for testing!


# ░██████████░██████  ░██████  ░██               ░██       ░██████████           ░██        
# ░██          ░██   ░██   ░██ ░██               ░██           ░██               ░██        
# ░██          ░██  ░██        ░██  ░███████  ░████████        ░██     ░██████   ░████████  
# ░█████████   ░██  ░██  █████ ░██ ░██    ░██    ░██           ░██          ░██  ░██    ░██ 
# ░██          ░██  ░██     ██ ░██ ░█████████    ░██           ░██     ░███████  ░██    ░██ 
# ░██          ░██   ░██  ░███ ░██ ░██           ░██           ░██    ░██   ░██  ░███   ░██ 
# ░██        ░██████  ░█████░█ ░██  ░███████      ░████        ░██     ░█████░██ ░██░█████  


#region || FIGlet Tab #TODO: Once we have the config tab ready we will undoubtedly have to rewrite this, but it works at the moment.
func write_to_window():
	var figlet_exec : String = "figlet"
	var figlet_input : String = input_text
	var out : Array = []
	var exit_code = OS.execute(figlet_exec, [figlet_input, "-w 120"], out)
	#var exit_code = OS.execute(figlet_exec, [figlet_input, "-f Terrace"], out) #intentionally-wrong setup, for testing
	if exit_code == -1:
		%Output.text = '''ERROR: exit_code == -1. Could not run FIGlet. Make sure FIGlet or pyFIGlet are actually installed, and make sure the executable is set for the appropriate version of FIGlet you are using.'''
	elif exit_code == 1:
		%Output.text = '''ERROR: exit_code == 1. Something isn't right, either with the FIGlet commands/tags or with your computer setup. Steps to take:
		1. Make sure you have the correct FIGlet executable. For example if you are on Windows and using pyfiglet, the executable should be \"pyfiglet\".
		2. If you are trying to input custom tags, make sure they're set up correctly. Remember: while both "-w, <width>" and "-w <width>" work fine, "-f <fontname>" does NOT work, yet "-f <fontname>" does -- for some reason!
			2a. Don't rule out blaming me! lol. Feel free to look at the plugin's scripts.
		3. Reset your project.
		4. Reset your computer.
		5. Reinstall your version of figlet.
		6. If you are using pyfiglet, try reinstalling or updating Python, and make sure pip works.'''
	elif exit_code == 0:
		%Output.text = r"%s" % out
	else:
		print("UNKNOWN ERROR: I only know what the exit codes -1, 1, and 0 mean. You got the exit code %s." % str(exit_code))


func format_as_comment() -> String:
	var work = %Output.text.split("\n")
	var out : String = ""
	for i in work:
		out += "# %s\n" % i
	out.trim_suffix("\n")
	return out



func _on_update_timer_timeout() -> void:
	if input_text != await_text:
		input_text = await_text
		write_to_window()


func _on_input_text_changed(new_text: String) -> void:
	await_text = new_text


func _on_copy_comment_pressed() -> void:
	%Output.text = format_as_comment()
	%Output.select_all()
	%Output.copy()
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


func populate_fonts_by_dir():
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
		%FontList.clear()
		for i in filelist:
			%FontList.add_item(i)
	else:
		print("Could not populate font list.")


func populate_fonts_by_tag():
	pass

func _on_change_font_toggled(toggled_on: bool) -> void:
	if !toggled_on: %FontList.deselect_all()
	build_tags()


func build_tags():
	pass




#endregion || /Main Body


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


func _on_exec_item_selected(index: int) -> void:
	%ExecCustom.editable = false
	figletexec_enum = index
	
	match index:
		FigletExec.Linux:
			figlet_exec = "figlet"
			%GetFontMethod.select(FontGetMethod.Dir)
		FigletExec.Windows:
			figlet_exec = "figlet"
			%GetFontMethod.select(FontGetMethod.Dir)
		FigletExec.PyFiglet:
			figlet_exec = "pyfiglet"
			%GetFontMethod.select(FontGetMethod.Tag)
		FigletExec.Custom:
			%GetFontMethod.select(FontGetMethod.Disable)
			figlet_exec = %ExecCustom.text
			%ExecCustom.editable = true


func _on_exec_custom_text_changed(new_text: String) -> void:
	figlet_exec = new_text


func _on_get_font_method_item_selected(index: int) -> void:
	%FontList.deselect_all()
	%ChangeFont.button_pressed = false
	match index:
		FontGetMethod.Dir:
			populate_fonts_by_dir()
		FontGetMethod.Tag:
			populate_fonts_by_tag()
		FontGetMethod.Disable:
			%ChangeFont.disabled = true
#endregion || /Setup Tab


#           ░██████                           ░██                                  ░██████████           ░██        
# ░██      ░██   ░██                          ░██                                      ░██               ░██        
#  ░██    ░██        ░██    ░██  ░███████  ░████████  ░███████  ░█████████████         ░██     ░██████   ░████████  
#   ░██   ░██        ░██    ░██ ░██           ░██    ░██    ░██ ░██   ░██   ░██        ░██          ░██  ░██    ░██ 
#  ░██    ░██        ░██    ░██  ░███████     ░██    ░██    ░██ ░██   ░██   ░██        ░██     ░███████  ░██    ░██ 
# ░██      ░██   ░██ ░██   ░███        ░██    ░██    ░██    ░██ ░██   ░██   ░██        ░██    ░██   ░██  ░███   ░██ 
#           ░██████   ░█████░██  ░███████      ░████  ░███████  ░██   ░██   ░██        ░██     ░█████░██ ░██░█████  
#region || Configuration Tab >> Customization Tab


func _on_cull_empty_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.


func _on_width_tag_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.


func _on_char_width_value_changed(value: float) -> void:
	pass # Replace with function body.


func _on_comment_prefix_text_changed(new_text: String) -> void:
	pass # Replace with function body.


func _on_tag_input_text_changed(new_text: String) -> void:
	pass # Replace with function body.
#endregion || /Customization Tab
#endregion || /Configuration Tab

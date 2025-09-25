#  //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //
#  \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\
#  //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //
#  \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\
#  //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //
#  \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\
#  //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //
#  \\-\\ \\-\\                                                                                       -\\ \\-\\ \\
#  //-// //-// ╻ ╻╻   ┏┓ ┏━┓┏━┓╺┳╸╻   ╻   ┏━┓┏┳┓   ╻ ╻┏━╸┏━┓╻ ╻╻┏┓╻┏━╸   ┏━┓┏┓╻   ┏━┓   ╻  ┏━┓┏━┓┏┳┓ -// //-// //
#  \\-\\ \\-\\ ┣━┫┃   ┣┻┓┣━┫┣┳┛ ┃ ╹   ┃   ┣━┫┃┃┃   ┃╻┃┣╸ ┣━┫┃┏┛┃┃┗┫┃╺┓   ┃ ┃┃┗┫   ┣━┫   ┃  ┃ ┃┃ ┃┃┃┃ -\\ \\-\\ \\
#  //-// //-// ╹ ╹╹   ┗━┛╹ ╹╹┗╸ ╹ ╹   ╹   ╹ ╹╹ ╹   ┗┻┛┗━╸╹ ╹┗┛ ╹╹ ╹┗━┛   ┗━┛╹ ╹   ╹ ╹   ┗━╸┗━┛┗━┛╹ ╹ -// //-// //
#  \\-\\ \\-\\                                                                                       -\\ \\-\\ \\
#  //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //
#  \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\
#  //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //
#  \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\
#  //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //
#  \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\-\\ \\
#  //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //-// //

@tool
extends Window


# ░██    ░██  ░██████   ░██░████  ░███████  
# ░██    ░██       ░██  ░███     ░██        
#  ░██  ░██   ░███████  ░██       ░███████  
#   ░██░██   ░██   ░██  ░██             ░██ 
#    ░███     ░█████░██ ░██       ░███████  
#region | members

enum ActiveTab { figlet = 0, config, help }
var active_tab : ActiveTab = ActiveTab.figlet # constructed
var loaded : bool = false # constructed

var await_string : String = ""
var input_string : String = "" # constructed
var tags : PackedStringArray # constructed

enum ExecMethod { none = -1, figlet, pyfiglet, custom }
var exec_method : ExecMethod = ExecMethod.none
var exec_string : String = "" # constructed
var custom_exec_string : String = ""

enum FontListMethod { off = -1, dir, tag, custom }
var font_list_method : FontListMethod = FontListMethod.off

var font_name : String = ""
var change_width_toggle : bool = false
var width : int = 80

enum CullEmptyMethod { off = 0, end, startend, all }
var cull_empty_method : CullEmptyMethod = CullEmptyMethod.startend

var comment_prefix : String = "# "

var custom_tags_toggle : bool = false
var custom_tags : String = ""

const patterns_path : String = "res://addons/FIGlet2Godot/border/saved/"
var border_patterns : Dictionary

#                  "      m                             #               
#   mmm   m   m  mmm    mm#mm          mmm    mmm    mmm#   mmm    mmm  
#  #"  #   #m#     #      #           #"  "  #" "#  #" "#  #"  #  #   " 
#  #""""   m#m     #      #           #      #   #  #   #  #""""   """m 
#  "#mm"  m" "m  mm#mm    "mm         "#mm"  "#m#"  "#m##  "#mm"  "mmm" 
#region | Exit Codes
const ExitCodes : Array[Dictionary] = [
	{
		"code" : -1, 
		"short" : "Could not execute.",
		"reason" : '''Could not run FIGlet. Make sure FIGlet or pyFIGlet are actually installed, and make sure Configuration/Setup/FIGlet Exec is set for the appropriate version of FIGlet you are using.'''
	},

	{
		"code" : 0,
		"short" : "OK",
		"reason" : "Executed properly."
	},
	
	{
		"code" : 1,
		"short" : "Bad setup or tags.",
		"reason" : '''Something isn't right, either with the FIGlet commands/tags or with your computer setup.

The most likely culprit is the font selection. If a font has been selected and Apply Font clicked, then the font currently typed into the Font line either does not exist or is invalid.
(While pyfiglet tends to filter these out, FIGlet does not.)

If you don't think that's the problem, here are some other things to try:

1. Make sure you have selected the correct FIGlet executable.

2. If you are trying to input custom tags, make sure they're set up correctly. Remember: while both \"-w,<width>\" and \"-w <width>\" work fine, \"-f <fontname>\" does NOT work, yet \"-f,<fontname>\" does -- for some reason!
	2a. Don't rule out blaming me! lol. Feel free to look at the plugin's scripts.

3. Reset your project.

4. Reset your computer.

5. Reinstall your version of figlet. If you are using pyfiglet, try reinstalling or updating Python, and if you're on Windows then make sure pip works, too!'''
	},

{
	"code" : 2,
	"short" : "Possibly bad tag setup.",
	"reason" : "I don't know exactly what causes this error, but it does seem to be related to the tags. Make sure your tags are written properly including comma-separating all the tags and comma-separating the font name from the font tag."
},

{
	"code" : 127,
	"short" : "Could not execute.",
	"reason" : '''The most likely reason for this error is the executable did not run. Reasons this may have happened:

1. You have just installed this plugin (welcome!); or you have not configured the plugin yet; or the settings file was deleted. For these issues, simply head to the Configuration tab.

2. Your chosen executable is not actually installed. Remember: this plugin requires an installation of FIGlet. See the Help tab for assistance.

3. Your chosen executable is not installed correctly, or your custom executable path does not point to the actual path of your executable. Test your installation in your system\'s terminal/command prompt; see the Help tab for more information.'''
},

{
	"code" : -255, #this is the number that should be passed to the dictionary for any code not listed above.
	"short" : "Unknown!",
	"reason" : "I do not know what this error code is. Sorry!"
}
]
#endregion

#  #             ""#                    m                    "                 
#  # mm    mmm     #    mmmm          mm#mm   mmm   mmmm   mmm     mmm    mmm  
#  #"  #  #"  #    #    #" "#           #    #" "#  #" "#    #    #"  "  #   " 
#  #   #  #""""    #    #   #           #    #   #  #   #    #    #       """m 
#  #   #  "#mm"    "mm  ##m#"           "mm  "#m#"  ##m#"  mm#mm  "#mm"  "mmm" 
#                       #                           #                          
#                       "                           "                          
#region | Help Topics
const HelpPrereq : String = '''	This plugin requires an installation of FIGlet or pyfiglet on your computer. (I recommend pyfiglet!)

	If you are on [b]Linux[/b], you can get FIGlet via [bgcolor=darkblue][color=yellow][code]sudo apt get figlet[/code][/color][/bgcolor] in the console, or you are likely able to get it through your distro\'s package manager. Alternately, you can get pyfiglet; you will need Python first. Then, just type [bgcolor=darkblue][color=yellow][code]sudo apt install python3-pyfiglet[/code][/color][/bgcolor] into the console.

	If you are on [b]Windows[/b] or [b]Mac[/b], you are almost certainly going to need pyfiglet. You will need to install Python, and then make sure pip works in your command prompt. Then, in the command prompt, type [bgcolor=darkblue][color=yellow][code]pip install pyfiglet[/code][/color][/bgcolor]. That should be it!

	Other versions and branches of FIGlet exist, and if you want to use those you will have to set this up yourself and make use of the Custom setting in the Configuration/Setup plugin tab.

	You will still need to make sure this plugin is set up correctly based on what you have installed.'''



const HelpSetup : String = '''	Go to the Configuration tab, then go to the Setup section. Choose the FIGlet Exec that coincides with which FIGlet installation you have on your system.

	[b]For most people, this will be all you need to do[/b] to get Figlet2Godot working.

	There's an option to set up some other form of FIGlet not accounted for by the preset options. If you are choosing this, you need to set the filepath that leads to the executable file for FIGlet. There's a chance your version of FIGlet has a different means to acquire the fonts folder, but there is not really a good way to accomodate this, so by default choosing the Custom option for the FIGlet Exec will set the Font List Method to Disabled, thus forcing you to provide your own tags.

	If you want to use your own tags, then under Customization, check the Custom Tags box, and have at it! Tags are comma-separated.
	[b]However![/b] For some reason, the font tag [bgcolor=darkblue][color=yellow][code]-f[/code][/color][/bgcolor] likes to be separated from the name of the font itself in this list, despite for example the width tag [bgcolor=darkblue][color=yellow][code]-w[/code][/color][/bgcolor] not caring if you include the actual width value with it (meaning you can do [bgcolor=darkblue][color=yellow][code]-w,80[/code][/color][/bgcolor] or [bgcolor=darkblue][color=yellow][code]-w 80[/code][/color][/bgcolor]; and likewise for most other tags).

	Example: You want the font "banner" and you want a width of 100. Your custom tags should be [bgcolor=darkblue][color=yellow][code]-f,banner,-w 80[/code][/color][/bgcolor].

	For FIGlet, head to http://www.figlet.org/ to find more information and the manpages. For pyfiglet, head to https://pypi.org/project/pyfiglet/ to learn more, and also go to your console/command prompt and type [bgcolor=darkblue][color=yellow][code]pyfiglet --help[/code][/color][/bgcolor] to learn about its options/tags. [b]The tags for FIGlet and pyfiglet are not all the same![/b]'''



const HelpEmptyFont : String = '''	The most likely culprit for the empty font list is an incorrect setup. Head to the Configuration tab, then go to the Setup section. Make sure you have the correct FIGlet Exec chosen (according to what you have installed on your system).

	Failing that, try changing the Font List Method. And failing that, you will simply have to manually enter your font in the text field above the empty font list; or even enter your own custom tags to change fonts.'''



const HelpErrors : String = '''	This addon uses the [bgcolor=darkblue][color=yellow][code]OS.execute()[/code][/color][/bgcolor] method in Godot to run the FIGlet installation on your system. This can mean errors occur at two different areas: the execution of FIGlet, or in the scripts of the plugin. Generally speaking, if no error pops up in your editor\'s Output console, then it's going to be an error at the execution.

	Errors showing up in your console are most likely due to the installation of FIGlet being wrong or the FIGlet Exec being set wrong in the plugin. Beyond that, I'm afraid I likely don't have an explanation.

	If you see an error message appearing in the font preview or the output window, it should be pretty self-explanatory. The most common error you\'re likely to see is the missing font error.'''

#endregion

#endregion


func _ready() -> void:
	populate_border_prefabs()
	load_settings()
	apply_settings()
	build_tags()
	if input_string != "": write_figlet()
	%HelpText.text = HelpPrereq
	loaded = true



func apply_settings():
	%Exec.select(get_setting("exec option"))
	_on_exec_item_selected(get_setting("exec option"))
	
	$%ExecCustom.text = get_setting("custom exec string")
	_on_exec_custom_text_changed(get_setting("custom exec string"))
	
	%FontListMethod.select(get_setting("font list method"))
	_on_font_list_method_item_selected(get_setting("font list method"))
	
	%FontName.text = get_setting("font name")
	_on_apply_font_pressed()
	
	%BlankLineCull.select(get_setting("cull empty method"))
	_on_blank_line_cull_item_selected(get_setting("cull empty method"))
	
	%WidthToggle.button_pressed = get_setting("change width toggle")
	_on_width_toggle_toggled(get_setting("change width toggle"))
	
	%Width.value = get_setting("width")
	_on_width_value_changed(get_setting("width"))
	
	%CommentPrefix.text = get_setting("comment prefix")
	_on_comment_prefix_text_changed(get_setting("comment prefix"))
	
	%CustomTagsToggle.button_pressed = get_setting("custom tags toggle")
	_on_custom_tags_toggle_toggled(get_setting("custom tags toggle"))
	
	%CustomTags.text = get_setting("custom tags")
	_on_custom_tags_text_changed(get_setting("custom tags"))
	
	%BorderToggle.button_pressed = get_setting("border active")
	_on_border_toggle_toggled(get_setting("border active"))
	
	%BorderPattern.text = get_setting("border pattern")
	_on_border_pattern_text_changed()
	
	%PatternName.text = get_setting("border pattern name")
	_on_pattern_name_text_changed(get_setting("border pattern name"))
	
	%SpacingUp.value = get_setting("border vspacing").x
	_on_spacing_up_value_changed(get_setting("border vspacing").x)
	%SpacingDown.value = get_setting("border vspacing").y
	_on_spacing_down_value_changed(get_setting("border vspacing").y)
	%SpacingLeft.value = get_setting("border hspacing").x
	_on_spacing_left_value_changed(get_setting("border hspacing").x)
	%SpacingRight.value = get_setting("border hspacing").y
	_on_spacing_right_value_changed(get_setting("border hspacing").y)
	
	%FillUp.value = get_setting("border vfill").x
	_on_fill_up_value_changed(get_setting("border vfill").x)
	%FillDown.value = get_setting("border vfill").y
	_on_fill_down_value_changed(get_setting("border vfill").y)
	%FillLeft.value = get_setting("border hfill").x
	_on_fill_left_value_changed(get_setting("border hfill").x)
	%FillRight.value = get_setting("border hfill").y
	_on_fill_right_value_changed(get_setting("border hfill").y)
	
	%Barber.value = get_setting("border barberpole")
	_on_barber_value_changed(get_setting("border barberpole"))



func _on_close_requested() -> void:
	queue_free()


#   ░██████                                 
#  ░██   ░██                                
# ░██         ░███████  ░██░████  ░███████  
# ░██        ░██    ░██ ░███     ░██    ░██ 
# ░██        ░██    ░██ ░██      ░█████████ 
#  ░██   ░██ ░██    ░██ ░██      ░██        
#   ░██████   ░███████  ░██       ░███████  
#region | Core methods

func set_exec_string() -> void: # called by figlet_exec; no need to call it elsewhere
	match exec_method:
		ExecMethod.none:
			exec_string = ""
		ExecMethod.figlet:
			exec_string = "figlet"
		ExecMethod.pyfiglet:
			exec_string = "pyfiglet"
		ExecMethod.custom:
			exec_string = custom_exec_string



func figlet_exec(_input : String, _tags : PackedStringArray) -> Dictionary:
	var exec_out : Array
	set_exec_string()
	var actual_tags : Array = [_input]
	for i in _tags: actual_tags.append(i)
	var code : int = OS.execute(exec_string, actual_tags, exec_out)
	return {
		"string" : r"%s" % exec_out,
		"code" : code
	}



func build_tags() -> void: #changes the value of tags
	tags.clear()
	# custom_tags_toggle overrides the other tags
	if custom_tags_toggle:
		var work = custom_tags.split(",", false)
		for i in work:
			tags.append(i.strip_edges())
			return # the rest does not fire
	
	var out : PackedStringArray
	if font_name.strip_edges() != "":
		out.append("-f")
		out.append(font_name.strip_edges())
	
	if change_width_toggle:
		out.append("-w %s" % str(int(width)))
	
	for i in out:
		tags.append(i)



func comprehend_figlet_exit_code(_code : int) -> Dictionary:
	var known_codes : Array[int]
	for i in ExitCodes:
		known_codes.append(i["code"])
	var found = known_codes.find(_code)
	if found == -1:
		var out = ExitCodes[-1].duplicate()
		out["code"] = _code
		return out
	else:
		return ExitCodes[found]



func write_figlet() -> void:
	var text : String
	var exec_out : Dictionary = figlet_exec(input_string, tags)
	var code = comprehend_figlet_exit_code(exec_out["code"])
	if code["code"] == 0: # all's well!
		%Output.wrap_mode = %Output.LINE_WRAPPING_NONE
		text = exec_out["string"]
		text = cull_empty_lines(text)
		text = "\n".join(correct_spacing(text.split("\n")))
		if border_toggle:
			var make_border : PackedStringArray = generate_bordered_block(text)
			text = "\n".join(make_border)
	else: # error!
		%Output.wrap_mode = %Output.LINE_WRAPPING_BOUNDARY
		text = "Exit Code %s\n\n%s" % [str(code["code"]), code["reason"]]
	
	%Output.text = text



func write_preview() -> void:
	if custom_tags_toggle:
		%Demo.text = "No preview available for custom tags."
		return
	var _preview_text : String = "AaBbCc"
	var _preview_tags : Array[String]
	if font_name != "":
		_preview_tags.append("-f")
		_preview_tags.append(font_name)
	var exec_out : Dictionary = figlet_exec(_preview_text, _preview_tags)
	var code = comprehend_figlet_exit_code(exec_out["code"])
	if code["code"] == 0: # all's well!
		%Demo.autowrap_mode = TextServer.AUTOWRAP_OFF
		%Demo.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		%Demo.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		_preview_text = cull_empty_lines(exec_out["string"], true)
	else: # error!
		%Demo.autowrap_mode = TextServer.AUTOWRAP_WORD
		%Demo.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		%Demo.vertical_alignment = VERTICAL_ALIGNMENT_TOP
		_preview_text = "Exit Code %s\n\n%s" % [str(code["code"]), code["reason"]]
	%Demo.text = _preview_text



func cull_empty_lines(_string : String, manual_cull : bool = false, manual_cull_method : CullEmptyMethod = CullEmptyMethod.startend) -> String:
	var actual_method : CullEmptyMethod
	if manual_cull: actual_method = manual_cull_method
	else: actual_method = cull_empty_method
	if actual_method == CullEmptyMethod.off: return _string
	var split = _string.split("\n")
	var culled
	
	match actual_method:
		
		CullEmptyMethod.end:
			var lastline : int = -1
			for i in range(split.size()-1,-1,-1):
				if split[i].dedent() != "":
					lastline = i
					break
			culled = split.slice(0,lastline+1)
	
		CullEmptyMethod.startend:
			var firstline : int = 0
			for i in split.size():
				if split[i].dedent() != "":
					firstline = i
					break
			var lastline : int = -1
			for i in range(split.size()-1,-1,-1):
				if split[i].dedent() != "":
					lastline = i
					break
			culled = split.slice(firstline,lastline+1)
		
		CullEmptyMethod.all:
			for i in range(split.size()-1,-1,-1):
				if split[i].dedent() == "":
					split.remove_at(i)
			culled = split
	
	return "\n".join(culled)



func populate_fonts_by_dir() -> void:
	%FontList.clear()
	var exec_out = figlet_exec("-I 2", []) #tells you where the font folder is
	var code = comprehend_figlet_exit_code(exec_out["code"])
	if code["code"] != 0: # all's well!
		print("Figlet2Godot, populate_fonts_by_dir || Exit Code %s\n\n%s" % [str(code["code"]), code["reason"]])
		return
	
	var dirpath : String = (r"%s" % exec_out["string"]).strip_edges()
	if dirpath == "": return
	var dir = DirAccess.open(dirpath)
	var filelist : PackedStringArray = dir.get_files()
	
	for i in range(filelist.size()-1, -1, -1):
		if !filelist[i].ends_with("flf") and !filelist[i].ends_with("flc"):
			filelist.remove_at(i)
		else:
			filelist[i] = filelist[i].trim_suffix(".flf").trim_suffix(".flc").strip_edges()
	
	for i in filelist:
		%FontList.add_item(i)
	%FontList.sort_items_by_text()



func populate_fonts_by_tag() -> void:
	%FontList.clear()
	var exec_out = figlet_exec("-l", []) #lists all available fonts
	var code = comprehend_figlet_exit_code(exec_out["code"])
	if code["code"] != 0: # all's well!
		print("Figlet2Godot, populate_fonts_by_tag || Exit Code %s\n\n%s" % [str(code["code"]), code["reason"]])
		return
	
	var work = r"%s" % exec_out["string"]
	var split = work.split("\n")
	var filelist : PackedStringArray
	
	for i in split:
		filelist.append(i.strip_edges())
	
	for i in filelist:
		%FontList.add_item(i)
	%FontList.sort_items_by_text()



func format_as_comment(_text : String) -> String:
	var split : PackedStringArray = _text.split("\n")
	var out : String
	for i in split:
		out += "%s%s\n" % [comment_prefix, i]
	out = out.trim_suffix("\n")
	return out

#endregion


# ░█████████                                   ░██           ░██                      
# ░██     ░██                                                                         
# ░██     ░██  ░███████   ░███████   ░███████  ░██░██    ░██ ░██░████████   ░████████ 
# ░█████████  ░██    ░██ ░██    ░██ ░██    ░██ ░██░██    ░██ ░██░██    ░██ ░██    ░██ 
# ░██   ░██   ░█████████ ░██        ░█████████ ░██ ░██  ░██  ░██░██    ░██ ░██    ░██ 
# ░██    ░██  ░██        ░██    ░██ ░██        ░██  ░██░██   ░██░██    ░██ ░██   ░███ 
# ░██     ░██  ░███████   ░███████   ░███████  ░██   ░███    ░██░██    ░██  ░█████░██ 
#                                                                                 ░██ 
#                                                                           ░███████  
#region | Signal receivers
func _on_update_timer_timeout() -> void:
	build_tags()
	if input_string != await_string:
		change_setting("input string", input_string, "String")
		input_string = await_string
		if active_tab == ActiveTab.figlet: write_figlet()
	if input_string == "" and active_tab == ActiveTab.figlet:
		%Output.text = ""


func _on_tab_container_tab_selected(tab: ActiveTab) -> void:
	active_tab = tab


func _on_input_text_changed(new_text: String) -> void:
	await_string = new_text


func _on_copy_comment_pressed() -> void:
	write_figlet()
	var t = format_as_comment(%Output.text)
	%Output.text = t
	%Output.select_all()
	%Output.copy()


func _on_copy_pressed() -> void:
	write_figlet()
	%Output.select_all()
	%Output.copy()


func _on_force_update_pressed() -> void:
	write_figlet()


func _on_font_name_text_changed(new_text: String) -> void:
	if new_text != font_name:
		%ApplyFont.disabled = false
	else:
		%ApplyFont.disabled = true


func _on_font_name_text_submitted(new_text: String) -> void:
	if new_text != font_name:
		%ApplyFont.disabled = true
		font_name = new_text
		write_preview()


func _on_apply_font_pressed() -> void:
	%ApplyFont.disabled = true
	font_name = %FontName.text
	change_setting("font name", font_name, "String")
	write_preview()


func _on_font_list_item_selected(index: int) -> void:
	%FontList.deselect_all()
	var f = %FontList.get_item_text(index)
	if f != "":
		%FontName.text = f
		_on_font_name_text_changed(f)


func _on_exec_item_selected(index: int) -> void:
	exec_method = index
	change_setting("exec option", exec_method, "int")
	set_exec_string()
	%ExecCustom.editable = false
	match exec_method:
		ExecMethod.none:
			%FontListMethod.select(FontListMethod.off)
			_on_font_list_method_item_selected(FontListMethod.off)
		ExecMethod.figlet:
			%FontListMethod.select(FontListMethod.dir)
			_on_font_list_method_item_selected(FontListMethod.dir)
		ExecMethod.pyfiglet:
			%FontListMethod.select(FontListMethod.tag)
			_on_font_list_method_item_selected(FontListMethod.tag)
		ExecMethod.custom:
			%FontListMethod.select(FontListMethod.custom)
			_on_font_list_method_item_selected(FontListMethod.custom)
			%ExecCustom.editable = true


func _on_exec_custom_text_changed(new_text: String) -> void:
	if new_text != custom_exec_string:	%ExecCustomOK.disabled = false
	else:								%ExecCustomOK.disabled = true


func _on_exec_custom_text_submitted(new_text: String) -> void:
	custom_exec_string = new_text
	change_setting("custom exec string", custom_exec_string, "String")
	%ExecCustomOK.disabled = true


func _on_exec_custom_ok_pressed() -> void:
	custom_exec_string = %ExecCustom.text
	change_setting("custom exec string", custom_exec_string, "String")
	%ExecCustomOK.disabled = true


func _on_font_list_method_item_selected(index: FontListMethod) -> void:
	%FontList.clear()
	font_list_method = index
	change_setting("font list method", font_list_method, "int")
	match index:
		FontListMethod.tag: populate_fonts_by_tag()
		FontListMethod.dir: populate_fonts_by_dir()


func _on_blank_line_cull_item_selected(index: CullEmptyMethod) -> void:
	cull_empty_method = index
	change_setting("cull empty method", cull_empty_method, "int")


func _on_width_toggle_toggled(toggled_on: bool) -> void:
	change_width_toggle = toggled_on
	change_setting("change width toggle", change_width_toggle, "bool")
	%Width.editable = toggled_on
	%GetWidth.disabled = !toggled_on


func _on_width_value_changed(value: float) -> void:
	width = value
	change_setting("width", width, "int")


func _on_get_width_pressed() -> void:
	var editor_settings = EditorInterface.get_editor_settings()
	var guideline = editor_settings.get_setting("text_editor/appearance/guidelines/line_length_guideline_hard_column")
	%Width.value = guideline
	width = guideline


func _on_comment_prefix_text_changed(new_text: String) -> void:
	comment_prefix = new_text.replace("\\t","\t")
	change_setting("comment prefix", comment_prefix, "String")


func _on_custom_tags_toggle_toggled(toggled_on: bool) -> void:
	%FontName.editable = !toggled_on
	%WidthToggle.disabled = toggled_on
	%Width.editable = !toggled_on
	custom_tags_toggle = toggled_on
	change_setting("custom tags toggle", custom_tags_toggle, "bool")
	write_preview()


func _on_custom_tags_text_changed(new_text: String) -> void:
	custom_tags = new_text
	change_setting("custom tags", custom_tags, "String")


func _on_help_topic_item_selected(index: int) -> void:
	match index:
		0: %HelpText.text = HelpPrereq
		1: %HelpText.text = HelpSetup
		2: %HelpText.text = HelpEmptyFont
		3: %HelpText.text = HelpErrors
#endregion



# ░████████                              ░██                                
# ░██    ░██                             ░██                                
# ░██    ░██   ░███████  ░██░████  ░████████  ░███████  ░██░████  ░███████  
# ░████████   ░██    ░██ ░███     ░██    ░██ ░██    ░██ ░███     ░██        
# ░██     ░██ ░██    ░██ ░██      ░██    ░██ ░█████████ ░██       ░███████  
# ░██     ░██ ░██    ░██ ░██      ░██   ░███ ░██        ░██             ░██ 
# ░█████████   ░███████  ░██       ░█████░██  ░███████  ░██       ░███████  
#region | Borders


#region | Border vars and signal funcs

var border_toggle : bool = false
var border_pattern : String = ""
var border_barberpole : int = 0
var border_hspacing : Vector2i = Vector2i.ZERO
var border_vspacing : Vector2i = Vector2i.ZERO
var border_hfill : Vector2i = Vector2i.ZERO
var border_vfill : Vector2i = Vector2i.ZERO


func _on_border_toggle_toggled(toggled_on: bool) -> void:
	border_toggle = toggled_on
	change_setting("border active", border_toggle, "bool")

func _on_border_pattern_text_changed() -> void:
	border_pattern = %BorderPattern.text
	change_setting("border pattern", border_pattern, "String")

func _on_barber_value_changed(value: float) -> void:
	border_barberpole = int(value)
	change_setting("border barberpole", border_barberpole, "int")

func _on_spacing_up_value_changed(value: float) -> void:
	border_vspacing.x = int(value)
	change_setting("border vspacing", border_vspacing, "Vector2i")
func _on_spacing_down_value_changed(value: float) -> void:
	border_vspacing.y = int(value)
	change_setting("border vspacing", border_vspacing, "Vector2i")

func _on_spacing_left_value_changed(value: float) -> void:
	border_hspacing.x = int(value)
	change_setting("border hspacing", border_hspacing, "Vector2i")
func _on_spacing_right_value_changed(value: float) -> void:
	border_hspacing.y = int(value)
	change_setting("border hspacing", border_hspacing, "Vector2i")

func _on_fill_up_value_changed(value: float) -> void:
	border_vfill.x = int(value)
	change_setting("border vfill", border_vfill, "Vector2i")
func _on_fill_down_value_changed(value: float) -> void:
	border_vfill.y = int(value)
	change_setting("border vfill", border_vfill, "Vector2i")

func _on_fill_left_value_changed(value: float) -> void:
	border_hfill.x = int(value)
	change_setting("border hfill", border_hfill, "Vector2i")
func _on_fill_right_value_changed(value: float) -> void:
	border_hfill.y = int(value)
	change_setting("border hfill", border_hfill, "Vector2i")

#endregion


func _find_longest_length(_psarray : PackedStringArray) -> int:
	var longest_length : int = 0
	for i in _psarray:
		if len(i) > longest_length:
			longest_length = len(i)
	return longest_length


func correct_spacing(_psarray : PackedStringArray) -> PackedStringArray: # makes sure every line in the pattern is the same length
	var longest : int = _find_longest_length(_psarray)
	for i in _psarray.size():
		var line : String = _psarray[i]
		if len(line) < longest:
			var diff = longest - len(line)
			line += " ".repeat(diff)
		_psarray[i] = line
	return _psarray


func get_block_dimensions(_text : String) -> Dictionary:
	var pattern = correct_spacing(border_pattern.split("\n"))
	var pattern_dim : Vector2i = Vector2i(_find_longest_length(pattern), pattern.size())
	
	var text = correct_spacing(_text.split("\n"))
	var text_dim : Vector2i = Vector2i(_find_longest_length(text), text.size())
	
	var total_spacing : Vector2i = Vector2i(border_hspacing.x + border_hspacing.y, border_vspacing.x + border_vspacing.y)
	var spaced_text_dim : Vector2i = text_dim + total_spacing
	
	var tf_width : int
	if border_hfill.x == -1 or border_hfill.y == -1:
		tf_width = width
	else:
		tf_width = border_hfill.x + border_hfill.y
	var total_fill : Vector2i = Vector2i(tf_width, border_vfill.x + border_vfill.y)
	var block_dim : Vector2i = spaced_text_dim + total_fill
	
	return {
		"total spacing" : total_spacing,
		"total fill" : total_fill,
		"pattern" : pattern_dim,
		"text" : text_dim,
		"spaced text" : spaced_text_dim,
		"block" : block_dim
	}


# this is the iteration on the pattern that goes into the block, shifted by a given amount left or right
# this simple thing caused me so much trouble lol, I don't wanna talk about it
func build_pattern_chunk(d : Dictionary, shift : int) -> PackedStringArray:
	var chunk : PackedStringArray
	if d["pattern"].x == 0: return chunk
	var pattern : PackedStringArray = correct_spacing(border_pattern.split("\n"))
	var reps : int = ceili(d["block"].x / d["pattern"].x)
	
	shift = (-shift) % d["pattern"].x
	if shift < 0: shift += d["pattern"].x
	
	for i in pattern:
		var line = i.repeat(reps + 3)
		if shift != 0:
			var thief = line.left(shift)
			line = line.trim_prefix(thief)
		line = line.left(d["block"].x)
		chunk.append(r"%s" % line)
	return chunk


func build_pattern_block(d : Dictionary) -> PackedStringArray:
	var reps : int = ceili(d["block"].y / d["pattern"].y) + 1
	var block : PackedStringArray
	for r in reps:
		var shift : int = r * border_barberpole
		var chunk : PackedStringArray = build_pattern_chunk(d, shift)
		for c in chunk:
			block.append(r"%s" % c)
	block.resize(d["block"].y)
	return block


func carve_pattern_block(d : Dictionary, pattern_block : PackedStringArray, text_block : PackedStringArray):
	var block : PackedStringArray
	var blankfill : String = " ".repeat(d["spaced text"].x)
	
	var extents : Vector2i = Vector2i(0, border_vfill.x)
	var extend := func(extension : int, prev : Vector2i) -> Vector2i:
		var out : Vector2i = prev
		out.x = prev.y
		out.y = prev.y + extension
		return out
	
	var get_sides := func(line : String) -> Array:
		return [line.left(border_hfill.x), line.right(border_hfill.y)]
	
	for i in range(extents.x, extents.y): # top fill
		block.append(pattern_block[i])
	
	extents = extend.call(border_vspacing.x, extents)
	for i in range(extents.x, extents.y): # top space
		var lr : Array = get_sides.call(pattern_block[i])
		block.append(lr[0] + blankfill + lr[1])
	
	extents = extend.call(d["text"].y, extents)
	for i in range(extents.x, extents.y): # text
		var lr : Array = get_sides.call(pattern_block[i])
		var textline : String = lr[0]
		textline += " ".repeat(border_hspacing.x)
		textline += text_block[i - extents.x]
		textline += " ".repeat(border_hspacing.y)
		textline += lr[1]
		block.append(r"%s" % textline)
	
	extents = extend.call(border_vspacing.y, extents)
	for i in range(extents.x, extents.y): # bottom space
		var lr : Array = get_sides.call(pattern_block[i])
		block.append(lr[0] + blankfill + lr[1])
	
	extents = extend.call(border_vfill.y, extents)
	for i in range(extents.x, extents.y): # bottom fill
		block.append(pattern_block[i])
	
	return block


func generate_bordered_block(_text : String) -> PackedStringArray:
	var dim = get_block_dimensions(_text)
	var pattern_block = build_pattern_block(dim)
	var block = carve_pattern_block(dim, pattern_block, _text.split("\n"))
	return block


func save_prefab(d : Dictionary, populate_after_save : bool = true):
	var new = FigletBorderPattern.new()
	new.pattern_name = d["pattern name"]
	new.pattern = d["pattern"]
	new.hspacing = d["hspacing"]
	new.vspacing = d["vspacing"]
	new.hfill = d["hfill"]
	new.vfill = d["vfill"]
	new.barberpole = d["barberpole"]
	var filename : String = d["pattern name"] + str(randi_range(10000000,99999999))
	var pattern_filenames = border_patterns.values()
	print(ResourceSaver.save(new, patterns_path + filename + ".tres", ResourceSaver.FLAG_REPLACE_SUBRESOURCE_PATHS))
	EditorInterface.get_resource_filesystem().scan()
	populate_border_prefabs()


func overwrite_prefab(d : Dictionary):
	var new = FigletBorderPattern.new()
	new.pattern_name = d["pattern name"]
	new.pattern = d["pattern"]
	new.hspacing = d["hspacing"]
	new.vspacing = d["vspacing"]
	new.hfill = d["hfill"]
	new.vfill = d["vfill"]
	new.barberpole = d["barberpole"]
	var filename : String = border_patterns[d["pattern name"]]
	print(ResourceSaver.save(new, filename, ResourceSaver.FLAG_REPLACE_SUBRESOURCE_PATHS))


func get_prefab_dict() -> Dictionary:
	var out : Dictionary = {
		"pattern name" : %PatternName.text,
		"pattern" : %BorderToggle.text,
		"hspacing" : Vector2i(int(%SpacingLeft.value), int(%SpacingRight.value)),
		"vspacing" : Vector2i(int(%SpacingUp.value), int(%SpacingDown.value)),
		"hfill" : Vector2i(int(%FillLeft.value), int(%FillRight.value)),
		"vfill" : Vector2i(int(%FillUp.value), int(%FillDown.value)),
		"barberpole" : %Barber.value
	}
	return out


func populate_border_prefabs():
	border_patterns.clear()
	var dir = DirAccess.open(patterns_path)
	var pattern_files = dir.get_files()
	
	for i in pattern_files:
		var respath = patterns_path + i
		var res = load(respath)
		border_patterns.merge({ res.pattern_name : respath })
	
	var pattern_names = border_patterns.keys()
	%Prefabs.clear()
	%Prefabs.add_item("- new -")
	for i in pattern_names:
		%Prefabs.add_item(i)



func _on_prefabs_item_selected(index: int) -> void:
	if index == 0: return
	var pname = %Prefabs.get_item_text(index)
	var filepath = border_patterns[pname]
	var res = load(filepath)
	%PatternName.text = res.pattern_name
	%BorderPattern.text = res.pattern
	border_pattern = res.pattern # needs to be manually set
	%SpacingUp.value = res.vspacing.x
	%SpacingDown.value = res.vspacing.y
	%SpacingLeft.value = res.hspacing.x
	%SpacingRight.value = res.hspacing.y
	%FillUp.value = res.vfill.x
	%FillDown.value = res.vfill.y
	%FillLeft.value = res.hfill.x
	%FillRight.value = res.hfill.y
	%Barber.value = res.barberpole



var save_prefab_new : bool = false # if false, then it will overwrite the matching file
func _on_pattern_name_text_changed(new_text: String) -> void:
	var pattern_names = border_patterns.keys()
	if !new_text in pattern_names:
		%DeletePrefab.disabled = true
		save_prefab_new = true
	else:
		%DeletePrefab.disabled = false
		save_prefab_new = false
	change_setting("border pattern name", new_text, "String")



func _on_save_prefab_pressed() -> void:
	if save_prefab_new:
		save_prefab(get_prefab_dict(), true)
	else:
		overwrite_prefab(get_prefab_dict())



func _on_delete_prefab_pressed() -> void:
	var prefab_index = %Prefabs.get_index()
	var prefab_text = %Prefabs.get_item_text(prefab_index)
	var filename = border_patterns[prefab_text]
	DirAccess.remove_absolute(filename)
	populate_border_prefabs()



#  //      /\      \\  //      /\      \\  //      /\      \\  //      /\      \\  //      /\      \\  //      /\
# //      //\\      \\//      //\\      \\//      //\\      \\//      //\\      \\//      //\\      \\//      //\
# /      //  \\      \/      //  \\      \/      //  \\      \/      //  \\      \/      //  \\      \/      //  
#       // /\ \\            // /\ \\            // /\ \\            // /\ \\            // /\ \\            // /\
#      // //\\ \\          // //\\ \\          // //\\ \\          // //\\ \\          // //\\ \\          // //\
#     // //  \\ \\        // //  \\ \\        // //  \\ \\        // //  \\ \\        // //  \\ \\        // //  
#    // // /\ \\ \\      // // /\ \\ \\      // // /\ \\ \\      // // /\ \\ \\      // // /\ \\ \\      // // /\
#   // // //\\ \\ \\    // // //\\ \\ \\    // // //\\ \\ \\    // // //\\ \\ \\    // // //\\ \\ \\    // // //\
#   \\ \\ \\// // //    \\ \\ \\// // //    \\ \\ \\// // //    \\ \\ \\// // //    \\ \\ \\// // //    \\ \\ \\/
#    \\ \\ \/ // //      \\ \\ \/ // //      \\ \\ \/ // //      \\ \\ \/ // //      \\ \\ \/ // //      \\ \\ \/
#     \\ \\  // //        \\ \\  // //        \\ \\  // //        \\ \\  // //        \\ \\  // //        \\ \\  
#      \\ \\// //          \\ \\// //          \\ \\// //          \\ \\// //          \\ \\// //          \\ \\/
#       \\ \/ //            \\ \/ //            \\ \/ //            \\ \/ //            \\ \/ //            \\ \/
# \      \\  //      /\      \\  //      /\      \\  //      /\      \\  //      /\      \\  //      /\      \\  
# \\      \\//      //\\      \\//      //\\      \\//      //\\      \\//      //\\      \\//      //\\      \\/
#  \\      \/      //  \\      \/      //  \\      \/      //  \\      \/      //  \\      \/      //  \\      \/
#  //      /\  ╻ ╻╻   ┏┓ ┏━┓┏━┓╺┳╸╻   ╻   ┏━┓┏┳┓   ╻ ╻┏━╸┏━┓╻ ╻╻┏┓╻┏━╸   ┏━┓┏┓╻   ┏━┓   ╻  ┏━┓┏━┓┏┳┓   //      /\
# //      //\\ ┣━┫┃   ┣┻┓┣━┫┣┳┛ ┃ ╹   ┃   ┣━┫┃┃┃   ┃╻┃┣╸ ┣━┫┃┏┛┃┃┗┫┃╺┓   ┃ ┃┃┗┫   ┣━┫   ┃  ┃ ┃┃ ┃┃┃┃ \//      //\
# /      //  \ ╹ ╹╹   ┗━┛╹ ╹╹┗╸ ╹ ╹   ╹   ╹ ╹╹ ╹   ┗┻┛┗━╸╹ ╹┗┛ ╹╹ ╹┗━┛   ┗━┛╹ ╹   ╹ ╹   ┗━╸┗━┛┗━┛╹ ╹ \/      //  
#       // /\ \\            // /\ \\            // /\ \\            // /\ \\            // /\ \\            // /\
#      // //\\ \\          // //\\ \\          // //\\ \\          // //\\ \\          // //\\ \\          // //\
#     // //  \\ \\        // //  \\ \\        // //  \\ \\        // //  \\ \\        // //  \\ \\        // //  
#    // // /\ \\ \\      // // /\ \\ \\      // // /\ \\ \\      // // /\ \\ \\      // // /\ \\ \\      // // /\
#   // // //\\ \\ \\    // // //\\ \\ \\    // // //\\ \\ \\    // // //\\ \\ \\    // // //\\ \\ \\    // // //\
#   \\ \\ \\// // //    \\ \\ \\// // //    \\ \\ \\// // //    \\ \\ \\// // //    \\ \\ \\// // //    \\ \\ \\/
#    \\ \\ \/ // //      \\ \\ \/ // //      \\ \\ \/ // //      \\ \\ \/ // //      \\ \\ \/ // //      \\ \\ \/
#     \\ \\  // //        \\ \\  // //        \\ \\  // //        \\ \\  // //        \\ \\  // //        \\ \\  
#      \\ \\// //          \\ \\// //          \\ \\// //          \\ \\// //          \\ \\// //          \\ \\/
#       \\ \/ //            \\ \/ //            \\ \/ //            \\ \/ //            \\ \/ //            \\ \/
# \      \\  //      /\      \\  //      /\      \\  //      /\      \\  //      /\      \\  //      /\      \\  
# \\      \\//      //\\      \\//      //\\      \\//      //\\      \\//      //\\      \\//      //\\      \\/
#  \\      \/      //  \\      \/      //  \\      \/      //  \\      \/      //  \\      \/      //  \\      \/
#  //      /\      \\  //      /\      \\  //      /\      \\  //      /\      \\  //      /\      \\  //      /\
# //      //\\      \\//      //\\      \\//      //\\      \\//      //\\      \\//      //\\      \\//      //\
# /      //  \\      \/      //  \\      \/      //  \\      \/      //  \\      \/      //  \\      \/      //  

#endregion



#   ░██████                 ░██       ░██    ░██                                 
#  ░██   ░██                ░██       ░██                                        
# ░██          ░███████  ░████████ ░████████ ░██░████████   ░████████  ░███████  
#  ░████████  ░██    ░██    ░██       ░██    ░██░██    ░██ ░██    ░██ ░██        
#         ░██ ░█████████    ░██       ░██    ░██░██    ░██ ░██    ░██  ░███████  
#  ░██   ░██  ░██           ░██       ░██    ░██░██    ░██ ░██   ░███        ░██ 
#   ░██████    ░███████      ░████     ░████ ░██░██    ░██  ░█████░██  ░███████  
#                                                                 ░██            
#                                                           ░███████             
#region | Settings

## This is the [Dictionary] that carries the current active settings of the program.
var settings : Dictionary

## The path that the settings file will be saved to.
const SettingsPath : String = "res://addons/FIGlet2Godot/Settings.json"

## The directory the settings file will be saved to.
const SettingsDir : String = "res://addons/FIGlet2Godot/"

## The actual name of the settings file (including file extension).
const SettingsFilename : String = "Settings.json"

## When creating a new settings file, these are the default settings put into that file.
const DefaultSettings = {
	"window size" : {
		"val" : "(720,500)",
		"type" : "Vector2i"
	},
	"input string" : {
		"val" : "",
		"type" : "String"
	},
	"exec option" : {
		"val" : -1,
		"type" : "int"
	},
	"custom exec string" : {
		"val" : "",
		"type" : "String"
	},
	"font list method" : {
		"val" : -1,
		"type" : "int"
	},
	"font name" : {
		"val" : "",
		"type" : "String"
	},
	"cull empty method" : {
		"val" : 2,
		"type" : "int"
	},
	"change width toggle" : {
		"val" : false,
		"type" : "bool"
	},
	"width" : {
		"val" : 80,
		"type" : "int"
	},
	"comment prefix" : {
		"val" : "# ",
		"type" : "String"
	},
	"custom tags toggle" : {
		"val" : false,
		"type" : "bool"
	},
	"custom tags" : {
		"val" : "",
		"type" : "String"
	},
	"border active" : {
		"val" : false,
		"type" : "bool"
	},
	"border pattern" : {
		"val" : "",
		"type" : "String"
	},
	"border pattern name" : {
		"val" : "",
		"type" : "String"
	},
	"border vspacing" : {
		"val" : "(0,0)",
		"type" : "Vector2i"
	},
	"border hspacing" : {
		"val" : "(0,0)",
		"type" : "Vector2i"
	},
	"border vfill" : {
		"val" : "(0,0)",
		"type" : "Vector2i"
	},
	"border hfill" : {
		"val" : "(0,0)",
		"type" : "Vector2i"
	},
	"border barberpole" : {
		"val" : 0,
		"type" : "int"
	}
}



## Loads the settings file.[br]
## Checks to see if the settings file exists, then loads that settings file,
## and then finally checks if the settings match the current possible settings
## in [constant DefaultSettings].
func load_settings():
	if !_check_for_settings_file():
		settings = DefaultSettings
		save_settings(true)
		load_settings()
	else:
		var source = FileAccess.open(SettingsPath, FileAccess.READ)
		settings = JSON.parse_string(source.get_as_text())
		source.close()
		_check_matching_settings()
		print("settings loaded")


## Saves the settings file to [constant SettingsPath].
func save_settings(force_save : bool = false):
	if loaded or force_save:
		var new_file = FileAccess.open(SettingsPath, FileAccess.WRITE)
		new_file.store_string(JSON.stringify(settings, "\t"))
		new_file.close()
		EditorInterface.get_resource_filesystem().scan() 
		print("settings saved")



## A simple check to see if the settings file already exists.[br]
## This function is called by [method load_settings] automatically.
func _check_for_settings_file() -> bool:
	var file_found = DirAccess.open(SettingsDir).file_exists(SettingsFilename)
	return file_found


## If setting are removed from, or new settings are added to, [constant DefaultSettings],
## this function makes sure that the settings file will reflect these alterations.[br]
## This method gets called by [method load_settings] automatically.
func _check_matching_settings():
	var changes_made : bool = false
	var defkeys : Array = DefaultSettings.keys()
	var extras_in_current_settings : Array
	for i in settings.keys():
		if !i in defkeys:
			extras_in_current_settings.append(i)
	for i in extras_in_current_settings:
		settings.erase(i)
	if extras_in_current_settings.size() != 0: changes_made = true

	var missing_from_settings : Array
	for i in defkeys:
		if !i in settings.keys():
			missing_from_settings.append(i)
	if missing_from_settings.size() != 0: changes_made = true
	settings.merge(DefaultSettings, false) # merges defaults with current settings, but does not overwrite any current key/value pairs
	
	if changes_made: save_settings()



## Use this function to change settings safely. Refer to [constant DefaultSettings] to see the
## list of settings that can be changed.
func change_setting(key : String, value, type : String, save_after_change : bool = true):
	if !loaded: return
	if !key in settings.keys(): return
	var _val : Variant
	if type == "Vector2i":
		_val = "(%s,%s)" % [value.x, value.y]
	else:
		_val = value
	var setting_dict = {
		"val" : _val,
		"type" : type
	}
	settings.set(key, setting_dict)
	if save_after_change: save_settings()


func get_setting(key : String) -> Variant:
	var out
	var _setting : Dictionary = settings[key]
	var v = _setting["val"]
	match _setting["type"]:
		"int":
			out = int(v)
		"float":
			out = float(v)
		"bool":
			out = bool(v)
		"String":
			out = String(v)
		"Vector2":
			var strip = v.trim_prefix("(").trim_suffix(")").split(",")
			out = Vector2( float(v[0]), float(v[1]) )
		"Vector2i":
			var strip = v.trim_prefix("(").trim_suffix(")").split(",")
			out = Vector2i( int(v[0]), int(v[1]) )
	return out


func _on_size_changed() -> void:
	if is_node_ready():
		change_setting("window size", size, "Vector2i")

#endregion

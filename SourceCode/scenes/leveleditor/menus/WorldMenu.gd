extends PopupDialog

onready var button_create_level = $VBoxContainer/ButtonList/HSplitContainer/CreateLevel
onready var button_open_level = $VBoxContainer/ButtonList/HSplitContainer/OpenLevel
onready var button_edit_world = $VBoxContainer/ButtonList/EditWorldProperties
onready var button_back = $VBoxContainer/Back
onready var label_world_name = $VBoxContainer/WorldName

onready var dialog_open_level = $SelectLevelDialog

func _on_WorldMenu_about_to_show():
	if !UserLevels.current_world:
		hide()
		push_error("Error creating World menu dialog: No user world was specified to open in UserLevels")
		return
	
	var world_name = UserLevels.get_world_name()
	label_world_name.bbcode_text = "[center][wave]" + world_name
	
	button_open_level.grab_focus()

func _on_Back_pressed():
	hide()

func _on_OpenLevel_pressed():
	dialog_open_level.popup()

func _on_CreateLevel_pressed():
	var level_filepath = UserLevels.create_level_in_world()
	if level_filepath != "":
		Global.load_level_editor_with_level(level_filepath)
	else:
		# Give the user an error message for creating the level
		pass

func _on_EditWorldProperties_pressed():
	pass # Replace with function body.

func _on_SelectLevelDialog_popup_hide():
	button_open_level.grab_focus()
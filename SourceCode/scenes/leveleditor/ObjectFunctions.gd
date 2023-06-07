extends Node2D

var object_container = null

var dragged_object = null

var can_place_objects = true

onready var tile_selection = $SelectedTile

func _ready():
	set_process(true)

func _process(delta):
	tile_selection.hide()
	
	if dragged_object:
		dragged_object.set_position(get_mouse_position(true))
	
	if object_container:
		
		if owner.can_place_tiles and !owner.mouse_over_ui:
			var selected_tile_position = get_mouse_position(true)
			tile_selection.show()
			tile_selection.set_position(selected_tile_position)

func _input(event):
	
	if event is InputEventMouseButton:
		
		# Let go of dragged objects when mouse released
		if event.button_index == BUTTON_LEFT and !event.pressed:
			can_place_objects = true
			
			if dragged_object:
				if is_instance_valid(dragged_object):
					dragged_object.position = get_mouse_position(true)
					dragged_object = null
		
		if can_place_objects and !owner.mouse_over_ui and !dragged_object and object_container:
			
			if event.pressed:
				var is_erasing = event.button_index == BUTTON_RIGHT or owner.eraser_enabled
				
				if !is_erasing and event.button_index == BUTTON_LEFT:
					place_object()

func place_object():
	owner.add_undo_state()
	var position = get_mouse_position(true)
	var object_to_add = owner.current_object_resource
	
	if !object_to_add: return
	if !object_container: return
	
	var object = object_to_add.instance()
	object.position = position
	object_container.add_child(object)
	object.set_owner(object_container)
	
	owner.play_sound("PlaceObject")

func grab_object(object): # Begin allowing an object to be dragged by the mouse.
	 # Only allow dragging objects which can have their position modified
	if object.get("position"):
		dragged_object = object

func delete_object(object):
	
	if object.get_owner() == owner: return
	
	owner.play_sound("EraseObject")
	
	owner.add_undo_state()
	object.queue_free()
	
	if dragged_object:
		if is_instance_valid(dragged_object):
			if dragged_object == object: dragged_object = null

func get_mouse_position(align_to_grid = true):
	var mouse_pos = get_global_mouse_position()
	if align_to_grid:
		mouse_pos /= Global.TILE_SIZE
		mouse_pos = Vector2(floor(mouse_pos.x), floor(mouse_pos.y))
		mouse_pos *= Global.TILE_SIZE
		mouse_pos += Global.TILE_SIZE * Vector2.ONE * 0.5
	return mouse_pos

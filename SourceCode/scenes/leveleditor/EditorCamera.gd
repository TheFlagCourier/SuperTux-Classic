extends Camera2D

export var move_speed = 32.0
export var mouse_drag_strength = 1.0
export var zoom_speed = 0.1

signal set_camera_drag(is_dragging)

var mouse_motion = Vector2.ZERO
var dragging_camera = false

func _input(event):
	# If we press the spacebar, enable camera drag mode.
	# This allows the camera to be moved by moving the mouse.
	if event.is_action("editor_move_camera"):
		dragging_camera = event.is_action_pressed("editor_move_camera", true)
		emit_signal("set_camera_drag", dragging_camera)
		if !dragging_camera: mouse_motion = Vector2.ZERO
	
	if event.is_action_pressed("editor_zoom_in") or event.is_action_pressed("editor_zoom_out"):
		var zoom_factor = 1 if event.is_action_pressed("editor_zoom_in") else -1
		zoom -= Vector2.ONE * zoom_speed * zoom_factor
		
		var mouse_pos = get_viewport().get_mouse_position()
		var mouse_pos_relative_to_center_of_screen = mouse_pos - ResolutionManager.window_resolution * Vector2(0.5,0.5)
		
		position += (mouse_pos_relative_to_center_of_screen * zoom_factor) * zoom_speed
	
	
	# If a mouse movement is detected and we are in camera drag mode,
	# move the camera by the mouse's relative movement * the specified mouse drag strength
	if event is InputEventMouseMotion:
		if dragging_camera:
			mouse_motion = event.relative * -1 * mouse_drag_strength

func camera_to_player_position(player : KinematicBody2D):
	if !player: return
	
	position = player.position
	position.y = limit_top + ResolutionManager.window_resolution.y * 0.5
	zoom = Vector2.ONE

func _process(delta):
	var cam_zoom = Vector2(get_global_transform_with_canvas().x.x, get_global_transform_with_canvas().y.y)
	
	var move_dir = Vector2()
	move_dir.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	move_dir.y = int(Input.is_action_pressed("duck")) - int(Input.is_action_pressed("move_up"))
	
	var velocity = move_dir * move_speed
	
	var edge_top = limit_top + ResolutionManager.window_resolution.y * 0.5 * zoom.y
	var edge_left = limit_left + ResolutionManager.window_resolution.x * 0.5 * zoom.x
	
	velocity += mouse_motion / cam_zoom
	
	position += velocity
	
	position.x = max(position.x, edge_left)
	position.y = clamp(position.y, edge_top, limit_bottom)

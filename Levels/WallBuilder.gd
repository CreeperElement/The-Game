extends Spatial

export var Scale = Vector3(.4, .4, .4)
onready var HalfWall = preload("res://DungeonPieces/half_wall.tscn")
onready var HalfWall_Ghost = preload("res://DungeonPieces/half_wall_ghost.tscn")
var ghost_wall
var camera
var mouse_down
var dictionary

var cardinalDirections = [
	Vector3(Scale.x, 0, 0),  # North
	Vector3(-Scale.x, 0, 0), # South
	Vector3(0, 0, Scale.z),  # East
	Vector3(0, 0, -Scale.z)] # West
var NORTH = cardinalDirections[0]
var SOUTH = cardinalDirections[1]
var EAST = cardinalDirections[2]
var WEST = cardinalDirections[3]

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_node("Camera")
	ghost_wall = HalfWall_Ghost.instance()
	add_child(ghost_wall)
	dictionary = {}

func _input(event):
	if(event is InputEventMouse):
		_handle_mouse_event(event)
	
func _handle_mouse_event(mouseEvent):
	mouseEvent = mouseEvent as InputEventMouse
	if(mouseEvent is InputEventMouseButton):
		_handle_mouse_button(mouseEvent)
	elif(mouseEvent is InputEventMouseMotion):
		_handle_mouse_move(mouseEvent)
		
func _handle_mouse_button(mouseButtonEvent):
	if mouseButtonEvent.button_index == BUTTON_LEFT:
		if mouseButtonEvent.pressed:
			mouse_down = true
			var dropPlane  = Plane(Vector3(0, 1, 0), 0)
			var position3D = dropPlane.intersects_ray(
								camera.project_ray_origin(mouseButtonEvent.position),
								camera.project_ray_normal(mouseButtonEvent.position))
			_add_tile(position3D)
		else:
			mouse_down = false

func _handle_mouse_move(mouseMoveEvent):
	var dropPlane  = Plane(Vector3(0, 1, 0), 0)
	var position3D = dropPlane.intersects_ray(
						camera.project_ray_origin(mouseMoveEvent.position),
						camera.project_ray_normal(mouseMoveEvent.position))
	if(mouse_down):
		_add_tile(position3D)
	ghost_wall.transform.origin = _snap_to_grid(position3D)

func _add_tile(position):
	var grid_coords = _snap_to_grid(position)
	if(!dictionary.has(grid_coords)):
		var newWall = HalfWall.instance()
		add_child(newWall)
		newWall.transform.origin = grid_coords
		_modify_wall_orientation(newWall)
		dictionary[grid_coords] = newWall
		
	for direction in cardinalDirections:
		var connectedPosition = grid_coords + direction
		if(!dictionary.has(connectedPosition)):
			continue # Skips to the top of the for loop
		var connectedWall = dictionary[connectedPosition]
		_modify_wall_orientation(connectedWall)

func _modify_wall_orientation(wall, default_horizontal = true, default_vetical = false):
	var is_horizontal = false
	var is_vertical = false
	var wall_position = wall.transform.origin
	
	if dictionary.has(wall_position + EAST):
		is_horizontal = true
	else:
		if dictionary.has(wall_position + NORTH) or dictionary.has(wall_position + SOUTH):
			is_horizontal = dictionary.has(wall_position + WEST) # Bottom right corner
	
	if(dictionary.has(wall_position + NORTH)):
		is_vertical = true
	
	# Should we or should we not use a default?
	if is_horizontal or is_vertical:
		wall.IsVertical = is_vertical
		wall.IsHorizontal = is_horizontal
	else:
		wall.IsVertical = default_vetical
		wall.IsHorizontal = default_horizontal

func _snap_to_grid(coordinate):
	var coord = coordinate as Vector3
	var x = int(coord.x / Scale.x)
	var y = int(coord.y / Scale.y)
	var z = int(coord.z / Scale.z)
	return Vector3(x * Scale.x, y * Scale.y, z*Scale.z)
	
	
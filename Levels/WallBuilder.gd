extends Spatial

export var Scale = Vector3(.4, .4, .4)
onready var HalfWall = preload("res://DungeonPieces/DragNDrop/half_wall.tscn")
onready var HalfWall_Ghost = preload("res://DungeonPieces/DragNDrop/half_wall_ghost.tscn")
var ghost_wall
var camera
var mouse_down
var dictionary

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
		newWall.transform.origin = grid_coords
		add_child(newWall)
		dictionary[grid_coords] = newWall
		print("Added one")

func _snap_to_grid(coordinate):
	var coord = coordinate as Vector3
	var x = int(coord.x / Scale.x)
	var y = int(coord.y / Scale.y)
	var z = int(coord.z / Scale.z)
	return Vector3(x * Scale.x, y * Scale.y, z*Scale.z)
	
	
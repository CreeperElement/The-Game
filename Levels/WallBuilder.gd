extends Spatial

export var Scale = Vector3(.4, .4, .4)
onready var HalfWall = preload("res://DungeonPieces/DragNDrop/half_wall.tscn")
var camera

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_node("Camera")

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
			var dropPlane  = Plane(Vector3(0, 1, 0), 0)
			var position3D = dropPlane.intersects_ray(
								camera.project_ray_origin(mouseButtonEvent.position),
								camera.project_ray_normal(mouseButtonEvent.position))
			var newWall = HalfWall.instance()
			newWall.transform.origin = _snap_to_grid(position3D);
			add_child(newWall)
			print("Converted Clikc at: ", position3D, " to: ", _snap_to_grid(position3D))
			
		else:
			print("Mouse Left Release at: ", mouseButtonEvent.position)

func _handle_mouse_move(mouseMoveEvent):
	pass

func _snap_to_grid(coordinate):
	var coord = coordinate as Vector3
	var x = int(coord.x / Scale.x)
	var y = int(coord.y / Scale.y)
	var z = int(coord.z / Scale.z)
	return Vector3(x * Scale.x, y * Scale.y, z*Scale.z)
	
	
extends KinematicBody

var gravity = Vector3.DOWN * 12
#var max_speed = 8
var speed = 4
var velocity = Vector3()
onready var body = get_node("Body")
var tagged = false

#var t = body.get_transform()
#var lastPos = t.origin()
#var value = 0

func _physics_process(delta):
	display_status()
	velocity += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector3.UP)
	
	#turn_model(delta)

func get_input():
#	var input_dir = Vector3()
#	if Input.is_action_pressed("move_forward"):
#		input_dir += -global_transform.basis.z
#	if Input.is_action_pressed("move_backward"):
#		input_dir += global_transform.basis.z
#	if Input.is_action_pressed("move_left"):
#		input_dir += -global_transform.basis.x
#	if Input.is_action_pressed("move_right"):
#		input_dir += global_transform.basis.x
#	input_dir = input_dir.normalized()
#	return input_dir
	velocity.x = 0
	velocity.z = 0
	if Input.is_action_pressed("move_forward"):
		velocity.z -= speed
	if Input.is_action_pressed("move_backward"):
		velocity.z += speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
		
#func turn_model(delta):
#	var lookDir = t.origin - lastPos
#	lastPos = t.origin
#	var rotTransform = t.looking_at(lookDir,Vector3(0,1,0))
#	var thisRotation = Quat(t.basis).slerp(rotTransform.basis,value)
#	value += delta
#	if value>1:
#    value = 1
#	set_transform(Transform(thisRotation,t.origin))

func _on_Collision_body_entered(body):
	tagged = !tagged
	
func display_status():
	if(tagged):
		$Status.show()
	if(!tagged):
		$Status.hide()
	
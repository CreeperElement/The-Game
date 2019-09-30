extends KinematicBody

var gravity = Vector3.DOWN * 12
#var max_speed = 8
var speed = 4
var velocity = Vector3()

func _physics_process(delta):
	velocity += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector3.UP)

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
	
extends KinematicBody

var gravity = Vector3.DOWN * 12
var acceleration = 4
var max_speed = 8
var terminal_velocity = 200
var velocity = Vector3(0, 0, 0)
var target = Vector3(0, 0, 0)


func _physics_process(delta):
	move(delta)

func move(delta):
	velocity += gravity * delta
	if velocity.z > terminal_velocity:
		velocity.z = terminal_velocity
	var distance_to_target = transform.origin.distance_to(target)
	
	var direction = target - transform.origin
	direction = Vector2(direction.x, direction.z)
	if(direction.length() >= 1):
		direction = direction.normalized()

	direction *= acceleration * delta
	velocity.x += direction.x
	velocity.z += direction.y
	
	velocity = move_and_slide(velocity, Vector3.UP)

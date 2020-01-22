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
	if velocity.y > terminal_velocity:
		velocity.y = terminal_velocity
	var distance_to_target = transform.origin.distance_to(target)
	
	var direction = target - transform.origin
	direction = Vector2(direction.x, direction.z)
	if(distance_to_target >= 1):
		direction = direction.normalized()
		acceleration = max_speed
	else:
		acceleration = 0

	direction *= acceleration * delta
	velocity.x += direction.x
	velocity.z += direction.y
	
	move_and_slide(velocity, Vector3.UP)

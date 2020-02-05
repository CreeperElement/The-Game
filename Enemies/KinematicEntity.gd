extends KinematicBody

var gravity = Vector3.DOWN * 12
var acceleration = 4
var max_speed = 8
var terminal_velocity = 200
var velocity = Vector3(0, 0, 0)
var target = Vector3(0, 0, 0)


func _physics_process(delta):
	move(delta)
	look(delta)

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
		if(distance_to_target > .05):
			direction = direction.normalized()
		else:
			acceleration = 0
			velocity = Vector3(0, 0, 0)
			transform.origin = Vector3(target.x, transform.origin.y, target.z)
			return

	direction *= acceleration * delta
	velocity.x += direction.x
	velocity.z += direction.y
	
	if(velocity.length() >= max_speed):
		velocity = velocity.normalized() * max_speed
	
	move_and_slide(velocity, Vector3.UP)


func look(delta):
	var localTarget = Vector2(target.x, target.z)
	var localOrigin = Vector2(transform.origin.z, transform.origin.z)
	var direction = localOrigin - localTarget
	if(direction.length() > .75):
		direction = direction.normalized()
		look_at(target, Vector3.UP);
	else:
		look_at(transform.origin + Vector3(direction.normalized().x, 0, direction.normalized().y), Vector3.UP)

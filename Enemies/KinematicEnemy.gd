extends KinematicBody

var gravity = Vector3.DOWN * 12
#var max_speed = 8
var speed = 4
var terminal_velocity = 200
var velocity = Vector3(0, 0, 0)
var target = Vector3()


func _physics_process(delta):
	velocity += gravity * delta
	if velocity.z > terminal_velocity:
		velocity.z = terminal_velocity
	var distance_to_target = transform.origin.distance_to(target)
	
	if distance_to_target > .001:
		var direction = target - transform.origin
		direction = direction.normalized()
		direction *= speed * delta
		velocity.x += direction.x
		velocity.z += direction.z
	velocity = move_and_slide(velocity, Vector3.UP)

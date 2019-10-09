extends KinematicBody

var gravity = Vector3.DOWN * 12
#var max_speed = 8
var speed = 3
var velocity = Vector3()
var target = preload("res://Players/Character1.tscn").instance()
onready var body = get_node("Body")

func _ready():
		body.add_child(target)

func _physics_process(delta):
	velocity += gravity * delta
	velocity.x = 0
	velocity.z = 0
	velocity += (target.get_global_transform().origin - body.get_global_transform().origin).normalized() * speed
	velocity = move_and_slide(velocity, Vector3.UP) #The "body." above shouldn't be there
extends KinematicBody

var gravity = Vector3.DOWN * 12
#var max_speed = 8
var speed = 3
var velocity = Vector3()
var target = preload("res://Players/Character1.tscn").instance()
onready var player_container = get_node("player_container")

func _ready():
		player_container.add_child(target)

func _physics_process(delta):
	var velocity = Vector3()
	velocity += gravity * delta
	velocity += (target.get_global_transform().origin - get_global_transform().origin).normalized() * speed
	velocity = move_and_slide(velocity, Vector3.UP)
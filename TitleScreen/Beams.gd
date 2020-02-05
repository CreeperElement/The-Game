extends Node2D

# For tinkering the beams
export var scroll_speed = 500
export var beams_count = 10
export var size_multiplier = 120
export var colors = ["#DF740C", "#FFE64D", "#E6FFFF", "#6FC3DF", "#0C141F"]
export var offset_starting_x = false

# Modified by the title screen
var offset = Vector2(0, 0)

# Set at run time
var x = 0
var screen_size
var color_options = []

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
	# Turn the boring hex strings into fabulous colors
	for c in colors:
		color_options.append(Color(c))
		
	if offset_starting_x:
		x = -screen_size.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Scroll the pipes
	x += delta * scroll_speed
	if x > screen_size.x:
		x = -2 * screen_size.x
	position = Vector2(x + offset.x, offset.y)

func _draw():
	# Draw method is only called once under normal conditions
	# check the Godot documentation for more details
	for i in range(beams_count):
		# Randomize size
		var width
		var height
		var multiplier = randf()
		if multiplier > 0.5:
			width = multiplier * size_multiplier
			height = (1 - multiplier) * size_multiplier
		else:
			width = (1 - multiplier) * size_multiplier
			height = multiplier * size_multiplier
		
		# Randomize location
		var rect = Rect2(
			randi() % int(screen_size.x * 2) - width, randi() % int(screen_size.y) - height,
			width, height)
		
		# Draw the beam on the screen
		draw_rect(rect, color_options[randi() % color_options.size()], true)

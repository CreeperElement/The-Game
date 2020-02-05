extends MarginContainer

# Size of the container
var size

var foregroundPipesWobbleIntensity = -50
var backgroundPipesWobbleIntensity = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	size = get_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Repel effect with the mouse
	var mouse = get_viewport().get_mouse_position()
	
	$ForegroundPipes1.offset.y = ((mouse.y - size.y / 2) / size.y) * foregroundPipesWobbleIntensity
	$ForegroundPipes2.offset.y = ((mouse.y - size.y / 2) / size.y) * foregroundPipesWobbleIntensity
	$BackgroundPipes1.offset.y = ((mouse.y - size.y / 2) / size.y) * backgroundPipesWobbleIntensity
	$BackgroundPipes2.offset.y = ((mouse.y - size.y / 2) / size.y) * backgroundPipesWobbleIntensity

func _on_PlayButton_pressed():
	# TODO: Implement game
	$HBoxContainer/VBoxContainer/VBoxContainer/PlayButton.text = "LOL. You thought you could play?"
	get_tree().change_scene("res://Spatial.tscn")

func _on_ExitButton_pressed():
	# Commit soduko
	get_tree().quit()

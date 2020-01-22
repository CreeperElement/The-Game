extends MarginContainer

# Size of the container
var size

# Called when the node enters the scene tree for the first time.
func _ready():
	size = get_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Repel effect with the mouse
	var mouse = get_viewport().get_mouse_position()
	$Pipes.offset.y = ((mouse.y - size.y / 2) / size.y) * -50

func _on_PlayButton_pressed():
	# TODO: Implement game
	$HBoxContainer/VBoxContainer/VBoxContainer/PlayButton.text = "LOL. You thought you could play?"

func _on_ExitButton_pressed():
	# Commit soduko
	get_tree().quit()

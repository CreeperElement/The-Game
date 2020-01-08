extends Node2D

var callbackFunc

func HandleStateChange():
	if GameState.currState == GameState.GameState.Reset:
		self.position.y = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.connect("StateChange", self, "HandleStateChange")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameState.currState != GameState.GameState.Paused:
		move_local_y(5)
		if self.position.y > 575:
			self.position.y = 0

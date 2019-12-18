extends Node

# All possible states the game can be in
enum GameState { GameOver, Running, Paused, Reset }

# The list of all currently registered players
var playerList = []

# The current state the game is in
var currState

# A signal raised when the global state changes
signal StateChange

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Method for handling everything that goes into changing a state
func ChangeState(state):
	currState = state
	emit_signal("StateChange")
	
	# If reset signal is sent, change the state to running immediatley after
	if state == GameState.Reset:
		ChangeState(GameState.Running)

# Add a new player to the global game pool
func addNewPlayer():
	var tmpPlayer = Player.new(playerList.size())
	playerList.append(tmpPlayer)
	return tmpPlayer

# A global class for defining what a player is
class Player:
	var score
	var id
	var name
	var names = ["Bob", "Bill", "Fred", "George"]
	
	func _init(id = -1, start_score = 0):
		self.score = start_score;
		self.id = id
		self.name = names[randi() % names.size()]
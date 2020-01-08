extends Node2D

# The time that's passed in game
var time = 0

# The player to interact with
var currentPlayer

# The label to write scores to
var scoreBox

# The player with the highest score
var topPlayer = GameState.Player.new()

# Function for handling state changes in the level
func HandleStateChange():
	if GameState.currState == GameState.GameState.GameOver:
		get_tree().change_scene("Levels/Welcome.tscn")
		
	elif GameState.currState == GameState.GameState.Reset:
		time = 0
		currentPlayer.score = 0
		for player in GameState.playerList:
			if player.score > topPlayer.score:
				topPlayer = player
		writeTopPlayer()
	

# Called when the node enters the scene tree for the first time.
func _ready():
	# Hook up HandleStateChange function to global StateChange signal
	GameState.connect("StateChange", self, "HandleStateChange")
	
	# Add new player to game state and player's score to scene
	currentPlayer = GameState.addNewPlayer()
	
	# Poplulate the scorebox
	for user in GameState.playerList:
		scoreBox = Label.new()
		scoreBox.set_text(user.name + "'s score: " + str(user.score))
		$ScoreVBox.add_child(scoreBox)
		if user.score > topPlayer.score:
			topPlayer = user
	writeTopPlayer()
	
	# Start playing the level
	GameState.ChangeState(GameState.GameState.Running)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameState.currState != GameState.GameState.Paused:
		time += delta
		currentPlayer.score += delta
		$TimeLabel.set_text("Time: " + str(time))
		scoreBox.set_text(currentPlayer.name + "'s score: " + str(currentPlayer.score))
		
		if currentPlayer.score > topPlayer.score:
			topPlayer = currentPlayer
		writeTopPlayer()

# Event handler for Start Button
func _on_StartButton_Pressed():
	GameState.ChangeState(GameState.GameState.Running)

# Event handler for Reset Button
func _on_Reset_Pressed():
	GameState.ChangeState(GameState.GameState.Reset)

# Event handler for Pause Button
func _on_PauseButton_Pressed():
	GameState.ChangeState(GameState.GameState.Paused)

# Event handler for End Game Button
func _on_EndGameButton_Pressed():
	GameState.ChangeState(GameState.GameState.GameOver)
	
# Helper function for setting top player's score
func writeTopPlayer():
	$ScoreVBox/TopScoreLabel.set_text("Top score: (" + topPlayer.name + ") " + str(topPlayer.score))

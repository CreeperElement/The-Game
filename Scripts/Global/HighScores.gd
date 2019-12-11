extends Node
var high_scores_path = "res://high_scores.txt"
var high_scores = {}

func load_high_scores():
	var saved_scores = File.new()
	if not saved_scores.file_exists(high_scores_path):
		var file_create = File.new()
		file_create.open(high_scores_path, File.WRITE)
		file_create.close()
	saved_scores.open(high_scores_path, File.READ)
	
	while(not saved_scores.eof_reached()):
		var score_line = saved_scores.get_line()
		var score_values = score_line.split(":")
		if len(score_values) < 2:
			continue
		var score = score_values[0]
		var players = []
		for i in range(1, score_values.size()):
			players.push_back((score_values[i]))
		high_scores[score] = players
	saved_scores.close()
	
func add_score(points, player_name):
	if not high_scores.has(str(points)):
		high_scores[str(points)] = []
	high_scores[str(points)].push_back(player_name)
	print("Adding: " + player_name + " with " + str(points) + " points.")

func write_scores():
	var saved_scores = File.new()
	saved_scores.open(high_scores_path, File.WRITE)
	var output = ""
	var keys = high_scores.keys()
	keys.sort()
	for i in range(0, len(keys)):
		var key = keys[i]
		output += str(key)
		for j in range(0, len(high_scores[key])):
			var value = high_scores[key][j]
			output += ":"+str(value)
		output += '\r\n'
	saved_scores.store_string(output)
	saved_scores.close()
	print(high_scores)

func _ready():
	load_high_scores()
	add_score(150, "A.S.S")
	add_score(15, "A.S.S")
	write_scores()
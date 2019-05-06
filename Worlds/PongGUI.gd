extends Control

var left_score = 0
var right_score = 0

func _ready():
	update_score()

func update_score():
	$LeftScore.text = str(left_score)
	$RightScore.text = str(right_score)

func _on_PongBall_scored(player):
	if  player == "left":
		left_score += 1
	else:
		right_score +=1
	update_score()

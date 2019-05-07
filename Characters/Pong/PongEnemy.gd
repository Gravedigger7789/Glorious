extends 'res://Characters/Pong/Pong.gd'

func apply_movement():
	var ball = get_node('../PongBall')
	position.y = ball.position.y

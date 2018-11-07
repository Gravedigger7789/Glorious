extends 'res://Characters/Pong/Pong.gd'

func apply_movement(delta):
	var ball = get_node('../PongBall')
	var destination = position.y - ball.position.y
	position.y = ball.position.y
	#print (destination)
	#linear_velocity.y = lerp(linear_velocity.y, destination, 0.1)

	#linear_velocity = move_and_slide(linear_velocity, FLOOR_NORMAL, SLOPE_SLIDE_STOP)
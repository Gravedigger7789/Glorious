extends KinematicBody2D

export(int) var walk_speed = 450

const FLOOR_NORMAL = Vector2()
const SLOPE_SLIDE_STOP = 5.0

var linear_velocity = Vector2()

func _physics_process(delta):
	apply_movement(delta)

func apply_movement(delta):
	# Moving
	var target_speed = Vector2()
	if Input.is_action_pressed('move_up'):
		target_speed.y += -1
	if Input.is_action_pressed('move_down'):
		target_speed.y += 1

	target_speed *= walk_speed
	linear_velocity.y = lerp(linear_velocity.y, target_speed.y, 0.1)

	linear_velocity = move_and_slide(linear_velocity, FLOOR_NORMAL, SLOPE_SLIDE_STOP)

extends State
class_name PlatformerState

const FLOOR_NORMAL := Vector2(0, -1)
const SLOPE_SLIDE_STOP := 25.0

var gravity := 980
var terminal_velocity := 750
var walk_speed := 450
var velocity := Vector2()

# func enter():
	# owner.get_node("AnimationPlayer").play(state_name)

func update(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.y = min(terminal_velocity, velocity.y)
	if owner is KinematicBody2D:
		velocity = owner.move_and_slide(velocity, FLOOR_NORMAL, SLOPE_SLIDE_STOP)

func get_input_direction() -> Vector2:
	var input_direction := Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	if owner.has_method("set_direction"):
		owner.set_direction(input_direction)
	return input_direction

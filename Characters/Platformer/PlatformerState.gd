extends State
class_name PlatformerState

const FLOOR_NORMAL := Vector2(0, -1)
const SLOPE_SLIDE_STOP := 25.0

var gravity := 16
var terminal_velocity := 750
var velocity := Vector2()

#func enter():
	#print(state_name)
	#owner.get_node("AnimationPlayer").play(state_name)

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_right") \
	or event.is_action_pressed("move_left") \
	or event.is_action_pressed("move_down") \
	or event.is_action_pressed("move_up"):
		get_tree().set_input_as_handled()

func get_input_direction() -> Vector2:
	var input_direction := Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	if "look_direction" in owner:
		owner.look_direction = input_direction
	return input_direction

# warning-ignore:unused_argument
func update(delta) -> void:
	apply_gravity()
	move()

func apply_gravity() -> void:
	velocity.y += gravity
	velocity.y = min(terminal_velocity, velocity.y)

func move() -> void:
	if owner is KinematicBody2D:
		velocity = owner.move_and_slide(velocity, FLOOR_NORMAL, SLOPE_SLIDE_STOP)

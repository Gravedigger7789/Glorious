extends State
class_name PlatformerState

func _ready() -> void:
	if !owner is Platformer:
		push_error("States owner must be of type Platformer")

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

func move(speed: float) -> void:
	if "velocity" in owner:
		var input_direction := get_input_direction()
		owner.velocity.x = input_direction.x * speed

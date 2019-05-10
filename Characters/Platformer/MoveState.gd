extends PlatformerState

func _init() -> void:
	state_name = "move"

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		emit_signal("change_state", "jump")
	.handle_input(event)

func update(delta: float) -> void:
	var input_direction := get_input_direction()
	if not input_direction:
		emit_signal("change_state", "idle")
	velocity.x = input_direction.x * walk_speed
	.update(delta)

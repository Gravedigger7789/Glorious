extends PlatformerState

func _init() -> void:
	state_name = "idle"

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		get_tree().set_input_as_handled()
		emit_signal("change_state", "jump")
	.handle_input(event)

func update(_delta: float) -> void:
	if get_input_direction():
		emit_signal("change_state", "move")
	if "velocity" in owner \
	and owner.velocity.y > 0:
			emit_signal("change_state", "fall")

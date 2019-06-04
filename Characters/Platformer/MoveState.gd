extends PlatformerState

export (int) var walk_speed := 450

func _init() -> void:
	state_name = "move"

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		get_tree().set_input_as_handled()
		emit_signal("change_state", "jump")
	.handle_input(event)

func update(_delta: float) -> void:
	move(walk_speed)
	if "velocity" in owner:
		if abs(owner.velocity.x) <= 0:
			emit_signal("change_state", "idle")
		if owner.velocity.y > 0:
			emit_signal("change_state", "fall")

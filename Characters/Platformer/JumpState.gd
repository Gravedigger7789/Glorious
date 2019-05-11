extends PlatformerState

export (int) var jump_speed := 450
export (int) var air_speed := 450

func _init() -> void:
	state_name = "jump"

func enter() -> void:
	velocity.y = -jump_speed
	.enter()

func update(delta: float) -> void:
	var input_direction := get_input_direction()
	velocity.x = input_direction.x * air_speed
	.update(delta)
	if owner is KinematicBody2D:
		if owner.is_on_floor():
			emit_signal("change_state", "idle")
	if velocity.y > 0:
		emit_signal("change_state", "fall")

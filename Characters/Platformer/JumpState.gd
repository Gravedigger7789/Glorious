extends PlatformerState

export (int) var jump_speed := 450
export (int) var air_speed := 450

func _init() -> void:
	state_name = "jump"

func enter() -> void:
	if "velocity" in owner:
		owner.velocity.y = -jump_speed
	.enter()

func update(_delta: float) -> void:
	move(air_speed)
	if owner is KinematicBody2D \
	and owner.is_on_floor():
			emit_signal("change_state", "idle")
	if "velocity" in owner \
	and owner.velocity.y > 0:
			emit_signal("change_state", "fall")

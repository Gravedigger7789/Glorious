extends PlatformerState

export (int) var air_speed := 450

func _init() -> void:
	state_name = "fall"

func update(_delta: float) -> void:
	move(air_speed)
	if owner is KinematicBody2D \
	and owner.is_on_floor():
			emit_signal("change_state", "idle")

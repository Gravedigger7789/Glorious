extends PlatformerState

var air_speed := 450

func _init() -> void:
	state_name = "fall"

func _ready() -> void:
	air_speed = owner.air_speed if "air_speed" in owner else air_speed
	._ready()

func update(_delta: float) -> void:
	move(air_speed)
	if owner is KinematicBody2D \
	and owner.is_on_floor():
			emit_signal("change_state", "idle")

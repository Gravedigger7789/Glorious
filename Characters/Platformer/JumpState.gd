extends PlatformerState

var jump_speed := 450
var air_speed := 450

func _init() -> void:
	state_name = "jump"

func _ready() -> void:
	jump_speed = owner.jump_speed if "jump_speed" in owner else jump_speed
	air_speed = owner.air_speed if "air_speed" in owner else air_speed
	._ready()

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

extends Node
class_name State

var state_name: String

signal change_state(next_state_name)

func _ready() -> void:
	set_physics_process(false)
	set_process_unhandled_input(false)

func enter() -> void:
	return

func exit() -> void:
	return

func handle_input(event: InputEvent) -> void:
	return

func update(delta: float) -> void:
	return

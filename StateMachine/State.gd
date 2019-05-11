extends Node
class_name State

# warning-ignore:unused_class_variable
var state_name: String

# warning-ignore:unused_signal
signal change_state(next_state_name)

func _ready() -> void:
	set_physics_process(false)
	set_process_unhandled_input(false)

func enter() -> void:
	return

func exit() -> void:
	return

# warning-ignore:unused_argument
func handle_input(event: InputEvent) -> void:
	return

# warning-ignore:unused_argument
func update(delta: float) -> void:
	return

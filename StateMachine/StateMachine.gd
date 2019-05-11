extends Node
class_name StateMachine

signal state_changed(currentState)

export (String) var START_STATE = "idle"

var states_map = {}
var states_stack = []
var current_state: State = null

func _ready() -> void:
	for child in get_children():
		if child is State:
			child.connect("change_state", self, "_on_change_state")
			states_map[child.state_name] = child
	initialize(START_STATE)

func initialize(state: String) -> void:
	states_stack.push_front(states_map[state])
	current_state = states_stack[0]
	current_state.enter()

func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)

func _physics_process(delta: float) -> void:
	current_state.update(delta)

func _on_change_state(state_name: String) -> void:
	current_state.exit()
	
	if state_name == "previous":
		states_stack.pop_front()
	else:
		states_stack[0] = states_map[state_name]
	
	current_state = states_stack[0]
	emit_signal("state_changed", current_state)
	
	if state_name != "previous":
		current_state.enter()

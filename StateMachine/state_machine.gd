class_name StateMachine extends Node

@export var _current_state: BaseState
@export var _states: Dictionary = {}
func _enter_tree() -> void:
	for child in get_children():
		if child is BaseState:
			child._transition_next_state.connect(_on_transition_states)
			_states[child.name] = child

func _ready() -> void:
	if _current_state == null:
		_current_state = get_child(0)

	_current_state.on_enter("",{})

func update(delta: float) -> void:
	_current_state.update(delta)

func physics_update(delta: float) -> void:
	_current_state.physics_update(delta)

func _on_transition_states(next_state: String, msg: Dictionary) -> void:
	if _states.has(next_state) == null:
		printerr("Dont exist " + next_state)
		return

	var target_state: BaseState = _states[next_state]
	var prev_state: String = _current_state.name
	_current_state.on_exit()
	_current_state = target_state
	_current_state.on_enter(prev_state,msg)

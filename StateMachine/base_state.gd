@abstract
class_name BaseState extends Node

signal _transition_next_state(next_state: String, msg: Dictionary)
signal _switch_sub_state(next_state: String, msg: Dictionary)
@export var _super_state: BaseState
@export var _sub_states: Dictionary
@export var _current_sub_state: BaseState
@export var _is_root_state: bool = false

func _ready() -> void:
	var parent: Node = get_parent()
	if parent is StateMachine:
		_is_root_state = true
		_switch_sub_state.connect(_tranition_sub_states)
	elif parent is BaseState:
		_super_state = parent
		parent._sub_states[self.name] = self
		_is_root_state = false

	load_components()

func _tranition_sub_states(next_state: String, msg: Dictionary) -> void:
	if _sub_states.has(next_state) == null:
		printerr("Dont exist " + next_state)
		return
	var target_state: BaseState = _sub_states[next_state]
	var prev_state: String = _current_sub_state.name
	_current_sub_state.on_exit()
	_current_sub_state = target_state
	_current_sub_state.on_enter(prev_state,msg)

func load_components() -> void:
	pass
@abstract
func on_enter(previous_state: String, msg: Dictionary) -> void
@abstract
func on_exit() -> void
@abstract
func update(delta: float) -> void
@abstract
func physics_update(delta: float) -> void

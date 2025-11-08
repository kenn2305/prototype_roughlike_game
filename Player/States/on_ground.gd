class_name OnGround extends BaseState
@export var player: Player
@export var _controller: CharacterBody2D
func load_components() -> void:
	player = owner
	_controller = player._controller

func on_enter(previous_state: String, msg: Dictionary) -> void:
	_controller.velocity.y = 0
	player.can_double_jump = true
	player.prim_atk_buffered = false
	player.second_atk_buffered = false
	player.can_air_dash = true
	if Input.is_action_pressed("left") || Input.is_action_pressed("right"):
		_current_sub_state = _sub_states["Run"]
	else:
		_current_sub_state = _sub_states["Idle"]

	_current_sub_state.on_enter(previous_state,msg)

func update(delta: float) -> void:
	if _current_sub_state != null:
		_current_sub_state.update(delta)

func physics_update(delta: float) -> void:
	if !_controller.is_on_floor() && !player.is_dash:
		_transition_next_state.emit("InAir",{"Fall": true})
		return

	if _current_sub_state != null:
		_current_sub_state.physics_update(delta)

func on_exit() -> void:
	if _current_sub_state != null:
		_current_sub_state.on_exit()

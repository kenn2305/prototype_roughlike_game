class_name InAir extends PlayerBaseState

func on_enter(previous_state: String, msg: Dictionary) -> void:
	player.prim_atk_buffered = false
	player.second_atk_buffered = false
	player._coyote_timer.start(player.coyote_time)
	if msg.has("Jump") && msg["Jump"] == true:
		_current_sub_state = _sub_states["Jump"]
	elif msg.has("Fall") && msg["Fall"] == true:
		_current_sub_state = _sub_states["Fall"]
	else:
		_current_sub_state = _sub_states["Fall"]

	_current_sub_state.on_enter(previous_state,msg)

func physics_update(delta: float) -> void:
	if controller.is_on_floor() && controller.velocity.y >= 0:
		_transition_next_state.emit("OnGround",{})
		return

	if _current_sub_state != null:
		_current_sub_state.physics_update(delta)

func on_exit() -> void:
	player.can_dash = true

	if _current_sub_state != null:
		_current_sub_state.on_exit()
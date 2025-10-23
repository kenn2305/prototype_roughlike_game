class_name Dash extends PlayerBaseState
@export var dash_decel: float
func on_enter(previous_state: String, msg: Dictionary) -> void:
	print("I am in " + self.name + " of " + _super_state.name)
	player._anim_player.play("Dash")
	player.is_dash = true
	player.air_decel = dash_decel
	if _super_state is InAir:
		player.can_air_dash = false
	elif _super_state is OnGround:
		player.can_dash = false
	player._dash_timer.start(player.dash_time)
		
func physics_update(delta: float) -> void:
	controller.velocity.y = 0
	controller.velocity.x = player.dash_velocity * player.direction
	if player.is_dash:
		return
	if self.name == "Dash":
		_super_state._switch_sub_state.emit("Idle",{})
	elif self.name == "AirDash":
		_super_state._switch_sub_state.emit("Fall",{})
func on_exit() -> void:
	player._dash_cool_down_timer.start(player.dash_cool_down)

class_name Attack extends PlayerBaseState
@export var current_skill: ComboNode
@export var attack_gravity: float
@export var attack_velocity: float
func on_enter(previous_state: String, msg: Dictionary) -> void:
	print("I am in " + self.name + " of " + _super_state.name)

func physics_update(delta: float) -> void:
	controller.velocity.x = 0
	_on_switch_state()
	_on_end_attack()
	active_primary_attack()
	active_secondary_attack()
	if _super_state is InAir:
		base_gravity(delta,attack_gravity)
		var dir = Input.get_axis("left","right")
		var target_velocity = attack_velocity * dir
		if dir != 0:
			base_movement(delta,target_velocity,player.air_accel)
			player.direction = dir
		elif dir == 0:
			base_movement(delta,target_velocity,player.air_decel)

func active_primary_attack() -> void:
	if player.prim_atk_buffered && player.can_attack && player._combo_cool_down_timer.is_stopped():
		player.can_attack = false
		player.is_attack = true
		if current_skill == null:
			current_skill = player._combo_tree.first_primary_node
			player._anim_player.play(&"RESET")
		else:
			var target_skill: ComboNode = current_skill.next_primary_node
			if target_skill == null:
				return
			current_skill = target_skill
			if current_skill.is_final_node:
				player._combo_cool_down_timer.start(1.0)
		
		player._anim_player.play(current_skill.active_skill.anim_name)
		if player.cancel_next_atk_wind_up:
			player._anim_player.seek(current_skill.active_skill.active_frame)
		player._combo_timer.start(player._anim_player.current_animation_length)
		print(current_skill.active_skill.anim_name)

func active_secondary_attack() -> void:
	if player.second_atk_buffered && player.can_attack && player._combo_cool_down_timer.is_stopped():
		player.can_attack = false
		player.is_attack = true
		if current_skill == null:
			current_skill = player._combo_tree.first_secondary_node
			player._anim_player.play(&"RESET")
		else:
			var target_skill: ComboNode = current_skill.next_secondary_node
			if target_skill == null:
				return
			current_skill = target_skill
			if current_skill.is_final_node:
				player._combo_cool_down_timer.start(1.0)
		
		player._anim_player.play(current_skill.active_skill.anim_name)
		if player.cancel_next_atk_wind_up:
			player._anim_player.seek(current_skill.active_skill.active_frame)
		player._combo_timer.start(player._anim_player.current_animation_length)

		print(current_skill.active_skill.anim_name)

func _on_combo_time_timeout() -> void:
	player.can_attack = true
	player.is_attack = false
	player.end_attack = false
	current_skill = null
	print("End combo")


func _on_combo_cool_down_timeout() -> void:
	if current_skill != null && current_skill.is_final_node:
		print("End Cool down")
		current_skill = null
		player.can_attack = true
		player.is_attack = false
		player.end_attack = false

func _on_switch_state() -> void:
	if player._combo_cool_down_timer.is_stopped() && (player.prim_atk_buffered || player.second_atk_buffered):
		return

	if !player.can_switch_in_atk:
		return

	if _super_state is OnGround:
		if Input.is_action_pressed("left") || Input.is_action_pressed("right"):
			_super_state._switch_sub_state.emit("Run",{})
		elif Input.is_action_just_pressed("dash"):
			_super_state._switch_sub_state.emit("Dash",{})
		elif player.jump_buffered:
			_super_state._transition_next_state.emit("InAir",{"Jump" : true})
	elif _super_state is InAir:
		_super_state._switch_sub_state.emit("Fall",{})

func on_exit() -> void:
	player.can_attack = true	
	player.is_attack = false
	player.end_attack = false
	player.cancel_next_atk_wind_up = false
	player.can_switch_in_atk = false
	current_skill = null


func _on_end_attack() -> void:
	if !player.end_attack:
		return
	player.can_attack = true
	player.is_attack = false
	print("Yes on ", _super_state)
	if _super_state is OnGround:
		_super_state._switch_sub_state.emit("Idle",{})
	elif _super_state is InAir:
		_super_state._switch_sub_state.emit("Fall",{})

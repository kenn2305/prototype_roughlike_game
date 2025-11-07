class_name Fall extends PlayerBaseState

func on_enter(previous_state: String, msg: Dictionary) -> void:
    print("I am in " + self.name + " of " + _super_state.name)
    player._anim_player.play("Fall")
    player.gravity = player.fall_gravity

func physics_update(delta: float) -> void:
    player._player_form.physics_update(delta)
    base_gravity(delta,player.max_gravity)
    var dir = Input.get_axis("left","right")
    var target_velocity = player.max_velocity * dir
    if dir != 0:
        base_movement(delta,target_velocity,player.air_accel)
        player.direction = dir
    elif dir == 0:
        base_movement(delta,target_velocity,player.air_decel)
    sprite.flip_h = player.direction < 0
    if dir != 0:
        player.direction = dir
    sprite.flip_h = player.direction < 0

    if !player._coyote_timer.is_stopped() && player.jump_buffered:
        _super_state._switch_sub_state.emit("Jump",{})
    elif Input.is_action_just_pressed("dash") && player.can_air_dash:
        _super_state._switch_sub_state.emit("AirDash",{})
    elif Input.is_action_just_pressed("jump") && player.can_double_jump:
        _super_state._switch_sub_state.emit("DB_Jump",{})
    elif player.prim_atk_buffered && player.can_attack && player._combo_cool_down_timer.is_stopped():
        _super_state._switch_sub_state.emit("Attack",{"Primary" : true})
    elif player.second_atk_buffered && player.can_attack && player._combo_cool_down_timer.is_stopped():
        _super_state._switch_sub_state.emit("Attack",{"Secondary" : true})


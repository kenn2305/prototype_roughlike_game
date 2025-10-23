class_name Jump extends PlayerBaseState
@export var air_resist: float
@export var jump_decel: float
func on_enter(previous_state: String, msg: Dictionary) -> void:
    print("I am in " + self.name + " of " + _super_state.name)
    player._anim_player.play("Jump")
    player._coyote_timer.stop()
    controller.velocity.y = -player.jump_velocity
    player.gravity = player.jump_gravity
    player.air_decel = jump_decel

func physics_update(delta: float) -> void:
    base_gravity(delta,player.max_gravity)
    if Input.is_action_just_released("jump"):
        controller.velocity.y *= 0.52

    var dir = Input.get_axis("left","right")
    var target_velocity = player.max_velocity * dir * air_resist
    if dir != 0:
        base_movement(delta,target_velocity,player.air_accel)
        player.direction = dir
    elif dir == 0:
        base_movement(delta,target_velocity,player.air_decel)
    sprite.flip_h = player.direction < 0

    if Input.is_action_just_pressed("dash") && player.can_air_dash:
        _super_state._switch_sub_state.emit("AirDash",{})
        return
    elif Input.is_action_just_pressed("jump") && player.can_double_jump:
        _super_state._switch_sub_state.emit("DB_Jump",{})
        return
    elif player.prim_atk_buffered && player.can_attack && player._combo_cool_down_timer.is_stopped():
        _super_state._switch_sub_state.emit("Attack",{"Primary" : true})
        return
    elif player.second_atk_buffered && player.can_attack && player._combo_cool_down_timer.is_stopped():
        _super_state._switch_sub_state.emit("Attack",{"Secondary" : true})
        return

    if controller.velocity.y >= 0:
        _super_state._switch_sub_state.emit("Fall",{})

func on_exit() -> void:
    pass
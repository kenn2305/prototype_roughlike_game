class_name Idle extends PlayerBaseState
@export var _deceleration: float

func on_enter(previous_state: String, msg: Dictionary) -> void:
    print("I am in " + self.name + " of " + _super_state.name)
    player._anim_player.play("Idle")

func physics_update(delta: float) -> void:
    if Input.is_action_just_pressed("dash") && player.can_dash:
        _super_state._switch_sub_state.emit("Dash",{})

    if Input.is_action_pressed("left") && !Input.is_action_pressed("right"):
        _super_state._switch_sub_state.emit("Run",{})
    elif Input.is_action_pressed("right") && !Input.is_action_pressed("left"):
        _super_state._switch_sub_state.emit("Run",{})
    elif player.prim_atk_buffered && player.can_attack && player._combo_cool_down_timer.is_stopped():
        _super_state._switch_sub_state.emit("Attack",{"Primary" : true})
    elif player.second_atk_buffered && player.can_attack && player._combo_cool_down_timer.is_stopped():
        _super_state._switch_sub_state.emit("Attack",{"Secondary" : true})
    elif player.jump_buffered:
        _super_state._transition_next_state.emit("InAir",{"Jump": true})
    base_movement(delta,0,_deceleration)

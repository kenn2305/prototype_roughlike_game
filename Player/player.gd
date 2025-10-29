class_name Player extends Node2D
@export_category("Components")
@export var _state_machine: StateMachine
@export var _controller: CharacterBody2D
@export var _sprite: Sprite2D
@export var _coyote_timer: Timer = Timer.new()
@export var _jump_buffer_timer: Timer = Timer.new()
@export var _dash_timer: Timer = Timer.new()
@export var _dash_cool_down_timer: Timer = Timer.new()
@export var _attack_buffer_timer: Timer = Timer.new()
@export var _anim_player: AnimationPlayer
@export var _combo_tree: ComboTree
@export var _combo_timer: Timer = Timer.new()
@export var _combo_cool_down_timer: Timer = Timer.new()
@export var _frame_data: Node
@export_category("OnGround/Movement")
@export var direction: float = 1
@export var max_velocity: float
@export_category("InAir/Movement")
@export var max_gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var gravity: float
@export var jump_height: float
@export var time_to_apex: float
@export var time_to_descent: float
@export var jump_velocity: float
@export var jump_gravity: float
@export var fall_gravity: float
@export var air_accel: float
@export var air_decel: float
@export var can_double_jump: bool = true
@export var coyote_time: float
@export var jump_buffered: bool = false
@export var jump_buffer_time: float
@export_category("Dash/Movement")
@export var dash_mult: float
@export var dash_velocity: float
@export var is_dash: bool = false
@export var dash_cool_down: float
@export var dash_time: float
@export var can_dash: bool = true
@export var can_air_dash: bool = true
@export_category("Attack")
@export var is_attack: bool = false
@export var can_attack: bool = true
@export var attack_buffered_time: float
@export var prim_atk_buffered: bool = false
@export var second_atk_buffered: bool = false
@export var can_switch_in_atk: bool = false
@export var end_attack: bool = false
@export var cancel_next_atk_wind_up: bool = false

func _enter_tree() -> void:
	_state_machine = find_child("StateMachine")
	_controller = find_child("CharacterBody2D")
	_sprite = find_child("Sprite2D")
	_anim_player = find_child("AnimationPlayer")
	_combo_tree = find_child("ComboTree")
	_combo_cool_down_timer = find_child("ComboCoolDown")
	_combo_timer = find_child("ComboTime")
	_frame_data = find_child("FrameData")

func _ready() -> void:
	init_variable()

func init_variable() -> void:
	#jump variable
	_coyote_timer.one_shot = true
	_jump_buffer_timer.one_shot = true
	_jump_buffer_timer.timeout.connect(_on_jump_buffer_timer_timeout)
	add_child(_coyote_timer)
	add_child(_jump_buffer_timer)
	jump_velocity = (2.0 * jump_height) / time_to_apex
	jump_gravity = (2.0 * jump_height) / (time_to_apex * time_to_apex)
	fall_gravity = (2.0 * jump_height) / (time_to_descent * time_to_descent)
	#dash
	dash_velocity = max_velocity * dash_mult
	_dash_timer.one_shot = true
	_dash_cool_down_timer.one_shot = true
	_dash_timer.timeout.connect(_on_dash_timer_timeout)
	_dash_cool_down_timer.timeout.connect(_on_dash_cool_down_timer_timeout)
	add_child(_dash_timer)
	add_child(_dash_cool_down_timer)
	#attack
	_combo_cool_down_timer.one_shot = true
	_combo_timer.one_shot = true
	_attack_buffer_timer.one_shot = true
	_attack_buffer_timer.timeout.connect(_on_attack_timer_timeout)
	add_child(_attack_buffer_timer)

func _process(delta: float) -> void:
	_state_machine.update(delta)

func _physics_process(delta: float) -> void:
	jump_input_buffered()
	attack_input_buffered()
	_frame_data.scale.x = direction
	_controller.move_and_slide()
	_state_machine.physics_update(delta)

func jump_input_buffered() -> void:
	if Input.is_action_just_pressed("jump"):
		jump_buffered = true
		_jump_buffer_timer.start(jump_buffer_time)

func attack_input_buffered() -> void:
	if Input.is_action_just_pressed("primary_attack") && !Input.is_action_pressed("secondary_attack"):
		prim_atk_buffered = true
		second_atk_buffered = false
		_attack_buffer_timer.start(attack_buffered_time)
	elif Input.is_action_just_pressed("secondary_attack") && !Input.is_action_pressed("primary_attack"):
		second_atk_buffered = true
		prim_atk_buffered = false
		_attack_buffer_timer.start(attack_buffered_time)

func _on_dash_timer_timeout() -> void:
	is_dash = false

func _on_dash_cool_down_timer_timeout() -> void:
	can_dash = true

func _on_jump_buffer_timer_timeout() -> void:
	jump_buffered = false

func _on_attack_timer_timeout() -> void:
	prim_atk_buffered = false
	second_atk_buffered = false

class_name PlayerBaseState extends BaseState
@export var player: Player
@export var controller: CharacterBody2D
@export var sprite: Sprite2D
func load_components() -> void:
	player = owner
	controller = player._controller
	sprite = player._sprite

func base_movement(delta: float, target_velocity: float ,friction: float) -> void:
	controller.velocity.x = lerp(controller.velocity.x, target_velocity, friction * delta) 

func base_gravity(delta: float, target_gravity: float) -> void:
	controller.velocity.y += player.gravity * delta

	if controller.velocity.y > target_gravity:
		controller.velocity.y = target_gravity

func on_enter(previous_state: String, msg: Dictionary) -> void:
	pass
func on_exit() -> void:
	pass
func update(delta: float) -> void:
	pass
func physics_update(delta: float) -> void:
	pass

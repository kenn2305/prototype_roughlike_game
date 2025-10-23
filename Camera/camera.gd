class_name PlayerCamera extends Node2D

@export var _player: Player
@export var _camera: Camera2D

func _enter_tree() -> void:
	_camera = find_child("PlayerCamera")
func _ready() -> void:
	_camera.position_smoothing_enabled = true
	_camera.position_smoothing_speed = 5.0
	_camera.process_callback = Camera2D.CAMERA2D_PROCESS_PHYSICS

func _physics_process(delta: float) -> void:
	_camera.global_position = _player._controller.global_position

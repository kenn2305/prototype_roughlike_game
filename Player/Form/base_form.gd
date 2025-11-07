class_name BaseForm extends BaseState

enum BUFF {NONE, RUN_FASTER, DASH_FUTHER, HASTE, JUMP_HIGH, DAMAGE_REDUCE}

@export var player: Player
@export var sprite: Sprite2D
@export var _color: Array[Color] = []
@export var form_container: FormContainer
@export var shader_material: ShaderMaterial
@export var frame_data_container: FrameDataContainer
@export	var buff: BUFF = BUFF.NONE

func load_components() -> void:
	player = owner
	sprite = player._sprite
	shader_material = sprite.material
	form_container = player._form_container
	frame_data_container = find_child("FrameData")

func on_enter(previous_state: String, msg: Dictionary) -> void:
	pass

func on_exit() -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass

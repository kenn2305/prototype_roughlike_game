class_name Attack_3 extends ActiveSkill

@export var dash_velocity: float

func _ready() -> void:
    super._ready()
    active_frame = 0.4

func active_dash_frame() -> void:
    player._controller.velocity.x = dash_velocity * Input.get_axis("left","right")
    await get_tree().create_timer(0.1).timeout
    player._controller.velocity.x = 0
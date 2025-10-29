class_name Attack_1 extends ActiveSkill

@export var dash_velocity: float

func _ready() -> void:
	super._ready()
	active_frame = 0.3

func active_dash_frame() -> void:
	player._controller.velocity.x = dash_velocity * player.direction if Input.get_axis("left","right") != 0 else dash_velocity * 0
	await get_tree().create_timer(0.1).timeout 
	player._controller.velocity.x = 0
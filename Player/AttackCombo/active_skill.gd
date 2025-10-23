class_name ActiveSkill extends Node2D
@export var _owner: Player
@export var anim_name: String
@export var anim_player: AnimationPlayer
@export var active_frame: float

func _ready() -> void:
	_owner = owner
	anim_name = self.name
	anim_player = _owner._anim_player

func set_time_seek() -> void:
	anim_player.seek(active_frame)

func set_animation() -> void:
	anim_player.play(anim_name)
class_name FrameDataObject extends CollisionShape2D

enum EffectType { NONE,STUN, KNOCK_BACK, KNOCK_UP,}
enum FrameType {ACTIVE, EMPTY,}
@export var frame_index: int
@export var priority: int
@export var effect_type: EffectType
@export var frame_type: FrameType
@export var screen_shake_force: float
@export var knock_back_force: float
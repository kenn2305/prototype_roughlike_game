class_name FrameDataObject extends CollisionShape2D

enum Elemental {NONE, FIRE, THUNDER, EARTH, WATER, WIND}
enum EffectType { NONE, BURN, VUNERABLE, SLOW, EXECUTE}
enum CrowdControl { NONE, STUN, KNOCK_BACK, KNOCK_UP}
enum FrameType {ACTIVE, EMPTY,}
@export var frame_index: int
@export var priority: int
@export var effect_type: EffectType
@export var elemetal: Elemental
@export var crowd_control: CrowdControl
@export var frame_type: FrameType
@export var screen_shake_force: float
@export var knock_back_force: float
# time of effect 
@export var effect_time: float
@export var cc_time: float
@export var effect_rate: float
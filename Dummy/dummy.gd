class_name Dummy extends CharacterBody2D

enum Elemental {NONE, FIRE, THUNDER, EARTH, WATER, WIND}
enum EffectType { NONE,STUN, KNOCK_BACK, KNOCK_UP, BURN, VUNERABLE, SLOW, EXECUTE}
enum ElementalReact {NONE, OVERLOAD, FREEZE, FIRESTORM, MUD, STEAM, ELECTROCUTE}
@export var hitbox_arr: Array[FrameDataObject] = []
@export var elemental_order: Array[FrameDataObject.Elemental]
@export var elemental_react: ElementalReact
@export var trigger_hitbox: FrameDataObject
@export var min_priority: int = 1000
@export var elemental: Elemental
@export var effect_type: EffectType
@export var cc_type: FrameDataObject.CrowdControl
@export var elemental_display: Sprite2D
@export var path: StringName = "none"
@export var elemental_exist_time: Timer = Timer.new()


func _ready() -> void:
	elemental_exist_time.one_shot = true
	elemental_exist_time.timeout.connect(_on_elemental_time_exist)
	add_child(elemental_exist_time)

func get_all_hitbox(hitbox: FrameDataObject) -> void:
	hitbox_arr.append(hitbox)


func trigger_effect() -> void:
	for data: FrameDataObject in hitbox_arr:
		if data.priority < min_priority:
			min_priority = data.priority
			trigger_hitbox = data

	if trigger_hitbox == null:
		return

	if trigger_hitbox.elemetal == Elemental.NONE:
		elemental = Elemental.NONE
		path = "none"
	elif trigger_hitbox.elemetal == Elemental.FIRE:
		elemental = Elemental.FIRE
		path = "res://Element_Icon/Fire.png"
	elif trigger_hitbox.elemetal == Elemental.THUNDER:
		elemental = Elemental.THUNDER
		path = "res://Element_Icon/Thunder.png" 
	elif trigger_hitbox.elemetal == Elemental.EARTH:
		elemental = Elemental.EARTH
		path = "res://Element_Icon/Earth.png" 
	elif trigger_hitbox.elemetal == Elemental.WATER:
		elemental = Elemental.WATER
		path = "res://Element_Icon/Water.png" 
	elif trigger_hitbox.elemetal == Elemental.WIND:
		elemental = Elemental.WIND
		path = "res://Element_Icon/Wind.png" 

	if trigger_hitbox.crowd_control == FrameDataObject.CrowdControl.STUN:
		trigger_stun(trigger_hitbox.cc_time)
	elif trigger_hitbox.crowd_control == FrameDataObject.CrowdControl.KNOCK_BACK:
		trigger_knockback(500.0)
	elif trigger_hitbox.crowd_control == FrameDataObject.CrowdControl.KNOCK_UP:
		trigger_knockup(800.0)
	else:
		print("None")

	elemental_exist_time.start(3.0)
	if path != "none":
		elemental_display.texture  = load(path)

	if !elemental_order.has(trigger_hitbox.elemetal) && trigger_hitbox.elemetal != Elemental.NONE:
		elemental_order.append(trigger_hitbox.elemetal)

	if elemental_order.size() == 2:
		elemental_react = get_element_react()
		elemental_order.clear()
		elemental_display.texture = null

	hitbox_arr.clear()
	min_priority = 1000
	trigger_hitbox = null


func _physics_process(delta: float) -> void:
	trigger_effect()
	gravity_update(delta)
	move_and_slide()

func get_element_react() -> int:
	elemental_order.sort()

	match elemental_order:
		[FrameDataObject.Elemental.FIRE, FrameDataObject.Elemental.THUNDER]:
			return ElementalReact.OVERLOAD
		[FrameDataObject.Elemental.FIRE, FrameDataObject.Elemental.WIND]:
			return ElementalReact.FIRESTORM
		[FrameDataObject.Elemental.EARTH, FrameDataObject.Elemental.WATER]:
			return ElementalReact.MUD
		[FrameDataObject.Elemental.THUNDER, FrameDataObject.Elemental.WATER]:
			return ElementalReact.ELECTROCUTE
		[FrameDataObject.Elemental.FIRE, FrameDataObject.Elemental.WATER]:
			return ElementalReact.STEAM
		[FrameDataObject.Elemental.WATER, FrameDataObject.Elemental.WIND]:
			return ElementalReact.FREEZE
		_:
			return ElementalReact.NONE

func _on_elemental_time_exist() -> void:
	elemental_order.clear()
	elemental = Elemental.NONE
	elemental_display.texture = null

func gravity_update(delta: float) -> void:
	if velocity.y >= 980:
		velocity.y = 980
	else:
		velocity.y += 3450 * delta 

func trigger_stun(cc_time: float) -> void:
	pass

func trigger_knockback(knock_back_force: float) -> void:
	velocity.x = knock_back_force
	await get_tree().create_timer(0.2).timeout
	velocity.x = 0

func trigger_knockup(knock_up_force: float) -> void:
	velocity.y = -knock_up_force

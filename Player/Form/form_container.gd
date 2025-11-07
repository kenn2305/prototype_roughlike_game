class_name FormContainer extends Node

enum FORM_TYPE{
	NORMAL,
	FIRE,
	THUNDER,
	EARTH,
	WIND,
	WATER,
}

@export var player: Player
@export var elemental_form: FORM_TYPE
@export var current_slot_index: int = 0
@export var form_container: Array[FORM_TYPE] = [FORM_TYPE.NORMAL,FORM_TYPE.NORMAL,FORM_TYPE.NORMAL]
@export var form_valiable: Array[FORM_TYPE] = [
	FORM_TYPE.FIRE,
	FORM_TYPE.THUNDER,
	FORM_TYPE.EARTH,
	FORM_TYPE.WIND,
	FORM_TYPE.WATER
]
@export var shuffled: Array[FORM_TYPE] = []

func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	reset()
	player = owner

func reset() -> void:
	shuffled = form_valiable.duplicate()
	shuffled.shuffle()

func update_form() -> void:
	if Input.is_action_just_pressed("increase"):
		player._elemental_ui.on_card_exit_select(current_slot_index)
		current_slot_index += 1
		if current_slot_index >= form_container.size():
			current_slot_index = 0
	elif Input.is_action_just_pressed("decrease"):
		player._elemental_ui.on_card_exit_select(current_slot_index)
		current_slot_index -= 1 
		if current_slot_index < 0:
			current_slot_index = form_container.size() - 1

	player._elemental_ui.on_card_is_select(current_slot_index)
	
	if Input.is_action_just_pressed("get_form"):
		get_random_form()
	elif Input.is_action_just_pressed("clear_form"):
		form_container[current_slot_index] = FORM_TYPE.NORMAL
		player._elemental_ui.set_texture("Normal",current_slot_index)

func get_random_form() -> void:

	if shuffled.is_empty():
		reset()

	elemental_form = shuffled.pop_back()
	if form_container[current_slot_index] == elemental_form:
		if shuffled.is_empty():
			reset()
		elemental_form = shuffled.pop_back()

		
	form_container[current_slot_index] = elemental_form
	
	if elemental_form == FORM_TYPE.FIRE:
		print("Fire")
		player._elemental_ui.set_texture("Fire",current_slot_index)
	elif elemental_form == FORM_TYPE.THUNDER:
		print("Thunder")
		player._elemental_ui.set_texture("Thunder",current_slot_index)
	elif elemental_form == FORM_TYPE.WATER:
		print("Water")
		player._elemental_ui.set_texture("Water",current_slot_index)
	elif elemental_form == FORM_TYPE.EARTH:
		print("Earth")
		player._elemental_ui.set_texture("Earth",current_slot_index)
	elif elemental_form == FORM_TYPE.WIND:
		print("Wind")
		player._elemental_ui.set_texture("Wind",current_slot_index)

			

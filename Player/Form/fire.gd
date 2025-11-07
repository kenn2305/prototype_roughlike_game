class_name Fire extends BaseForm

func on_enter(previous_state: String, msg: Dictionary) -> void:
	print("I am in " + self.name + "form")
	shader_material.set_shader_parameter("replace_color", [_color[0],_color[1]])

	for index: int in range(frame_data_container.container.size()):
		player._frame_data.set_frame_data(index, frame_data_container.container[index].frame_data_hitbox_data)

func physics_update(delta: float) -> void:
	form_container.update_form()
	
	if form_container.form_container[form_container.current_slot_index] == form_container.FORM_TYPE.NORMAL:
		_transition_next_state.emit("Normal",{})
	elif form_container.form_container[form_container.current_slot_index] == form_container.FORM_TYPE.THUNDER:
		_transition_next_state.emit("Thunder",{})
	elif form_container.form_container[form_container.current_slot_index] == form_container.FORM_TYPE.WATER:
		_transition_next_state.emit("Water",{})
	elif form_container.form_container[form_container.current_slot_index] == form_container.FORM_TYPE.EARTH:
		_transition_next_state.emit("Earth",{})
	elif form_container.form_container[form_container.current_slot_index] == form_container.FORM_TYPE.WIND:
		_transition_next_state.emit("Wind",{})
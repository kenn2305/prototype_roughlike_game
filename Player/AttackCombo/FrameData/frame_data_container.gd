class_name FrameDataContainer extends Node2D

@export var container: Array[FrameData] = []

func _ready() -> void:
	var parent = get_parent()
	for child: FrameData in get_children():
		container.append(child)

	if parent is BaseForm:
		for index: int in range(container.size()):
			container[index].debug_color(parent._color[0])


func set_frame_data(value: int, target_frame_data: Dictionary) -> void:
	var frame_data: FrameData = container[value]
	frame_data.frame_data_hitbox_data.clear()
	for child in frame_data.get_children():
		child.queue_free()

	for key in target_frame_data.keys():
		var new_data: Array = target_frame_data[key]
		var new_array: Array = []

		for frame_object in new_data:
			if frame_object is FrameDataObject:
				var duplicate_obj = frame_object.duplicate()
				frame_data.add_child(duplicate_obj)
				new_array.append(duplicate_obj)

		frame_data.frame_data_hitbox_data[key] = new_array




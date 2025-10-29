class_name FrameData extends Area2D

@export var frame_data_hitbox_data: Dictionary = {}
@export var current_frame_index: int
@export var skill: ActiveSkill

func _ready() -> void:
	for child in get_children():
		child = child as FrameDataObject
		if !frame_data_hitbox_data.has(child.frame_index):
			frame_data_hitbox_data[child.frame_index] = []
			frame_data_hitbox_data[child.frame_index].append(child)
		else:
			frame_data_hitbox_data[child.frame_index].append(child)
		child.visible = false
		if child.frame_type == child.FrameType.EMPTY:
			child.shape = null
			child.disabled = true

	self.monitoring = false
	self.monitorable = false

func get_frame_active(value: int) -> void:
	current_frame_index = value
	for frame in frame_data_hitbox_data[current_frame_index]:
		if frame.frame_type == frame.FrameType.ACTIVE:
			frame.disabled = false
			frame.visible = true
			self.monitorable = true
			self.monitoring = true
			self.visible = true
		elif frame.frame_type == frame.FrameType.EMPTY:
			frame.disabled = true
			frame.visible = false
			self.monitorable = false
			self.monitoring = false
			self.visible = false
			
func end() -> void:
	self.monitorable = false
	self.monitoring = false
	self.visible = false
	
	for child in frame_data_hitbox_data.values():
		for frame in child:
			frame.disabled = true

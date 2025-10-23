class_name PrimaryNode extends ComboNode

func _ready() -> void:
	var parent: Node = get_parent()
	if parent is ComboTree:
		parent.first_primary_node = self
	elif parent is ComboNode:
		parent.next_primary_node = self

	if next_primary_node == null && next_secondary_node == null:
		is_final_node = true
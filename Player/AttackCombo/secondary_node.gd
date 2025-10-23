class_name SecondaryNode extends ComboNode

func _ready() -> void:
	var parent: Node = get_parent()
	if parent is ComboTree:
		parent.first_secondary_node = self
	elif parent is ComboNode:
		parent.next_secondary_node = self

	if next_primary_node == null && next_secondary_node == null:
		is_final_node = true
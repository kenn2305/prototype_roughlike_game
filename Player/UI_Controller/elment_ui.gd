class_name ElementUi extends Control

@export var element_card: Array[Card] = []

func _ready() -> void:
	for child: Card in get_children():
		child.get_texture_card("Normal")
		element_card.append(child)

func on_card_is_select(index: int) -> void:
	element_card[index].on_selected()

func on_card_exit_select(index: int) -> void:
	element_card[index].on_exit_select()

func set_texture(name: String, index: int) -> void:
	element_card[index].get_texture_card(name)

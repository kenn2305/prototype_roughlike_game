class_name Card extends Button

var tween_on_enter: Tween
@export var card_texture: TextureRect

func _enter_tree() -> void:
	card_texture = find_child("CardTexture")

func on_selected() -> void:
	if tween_on_enter && tween_on_enter.is_running():
		tween_on_enter.kill()

	tween_on_enter = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).set_parallel(true)
	tween_on_enter.tween_property(self, "scale", Vector2(1.35,1.35), 0.5)

func on_exit_select() -> void:

	if tween_on_enter && tween_on_enter.is_running():
		tween_on_enter.kill()

	tween_on_enter = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_on_enter.tween_property(self, "scale", Vector2.ONE, 0.55)

func get_texture_card(name: String) -> void:
	var path: String = "res://Player/Form/Elemental/" + name + ".png"
	var texture = load(path)

	if texture == null:
		printerr("Cant find texture")
		return 
	card_texture.texture = texture

func _on_mouse_entered() -> void:
	on_selected()


func _on_mouse_exited() -> void:
	on_exit_select()

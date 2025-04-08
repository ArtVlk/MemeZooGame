extends Area2D

func _input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Вызываем окно выбора, передавая ссылку на этот спавнер
		get_tree().current_scene.show_cage_selection_window(self)

# Метод для создания клетки по выбранной сцене
func spawn_cage(cage_scene: PackedScene) -> void:
	var cage = cage_scene.instantiate()
	# Добавляем созданную клетку в основную сцену
	get_tree().current_scene.add_child(cage)
	
	# Если у клетки есть дочерний Sprite с именем "Sprite", вычисляем смещение
	var sprite_node = cage.get_node_or_null("Sprite")
	if sprite_node and sprite_node is Sprite2D:
		var offset = sprite_node.texture.get_size() * 0.5
		cage.global_position = global_position - offset
	else:
		cage.global_position = global_position
	
	# Удаляем спавнер после создания клетки
	queue_free()

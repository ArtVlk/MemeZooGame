extends Area2D

@export var cage_packed_scene: PackedScene


func _input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		spawn_cage()

func spawn_cage() -> void:
	# Инстанцируем сцену клетки
	var cage = cage_packed_scene.instantiate()
	
	# Добавляем клетку в текущую сцену
	get_tree().current_scene.add_child(cage)
	
	# Если у клетки есть дочерний Sprite с именем "Sprite",
	# вычисляем смещение, чтобы позиция спавнера совпадала с центром клетки.
	var sprite_node = cage.get_node_or_null("Sprite")
	if sprite_node and sprite_node is Sprite2D:
		# Предполагаем, что точка привязки спрайта в левом верхнем углу,
		# поэтому смещение = половина размера текстуры
		var offset = sprite_node.texture.get_size() * 0.5
		cage.global_position = global_position - offset
	else:
		# Если спрайта нет или его имя другое, просто ставим по глобальной позиции спавнера
		cage.global_position = global_position
	
	# Удаляем спавнер после создания клетки
	queue_free()

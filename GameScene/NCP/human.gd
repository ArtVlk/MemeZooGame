extends CharacterBody2D

@onready var path_follow = get_parent()
@onready var animated_sprite = $AnimatedSprite

func _physics_process(delta):
	# Двигаем по пути
	var prev_position = path_follow.global_position  # Запоминаем прошлую позицию
	path_follow.progress += 250 * delta  # Двигаем по пути
	var new_position = path_follow.global_position  # Новая позиция
	
	# Вычисляем направление движения
	var direction = (new_position - prev_position).normalized()
	
	# Определяем анимацию по направлению движения
	if abs(direction.x) > abs(direction.y):  # Горизонтальное движение
		if direction.x > 0:
			animated_sprite.play("walking_right")
		else:
			animated_sprite.play("walking_left")
	else:  # Вертикальное движение
		if direction.y > 0:
			animated_sprite.play("walking_down")
		else:
			animated_sprite.play("walking_up")
	
	# Удаляем объект, если он дошёл до конца пути
	if path_follow.progress_ratio >= 1.0:
		queue_free()

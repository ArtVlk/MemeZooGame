extends CharacterBody2D

@onready var path_follow = get_parent()
@onready var animated_sprite = $AnimatedSprite

var initial_money: int
var ticket_price: int

func _ready():
	randomize()
	initial_money = randi() % 151 + 50  # 50-200
	ticket_price = randi() % 41 + 10    # 10-50
	Global.add_money(ticket_price)
	initial_money -= ticket_price
	print("Вышел новый житель")
	print("Денег: ", initial_money)
	print("Его цена билета: ", ticket_price)

func _physics_process(delta):
	# Двигаем по пути
	var prev_position = path_follow.global_position  # Запоминаем прошлую позицию
	path_follow.progress += 150 * delta  # Двигаем по пути
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
		var popularity_change = randi() % 11 - 5  # -5 до +5
		Global.add_popularity(popularity_change)
		print("Посетитель покинул зоопарк! Популярность изменена на: ", popularity_change)
		queue_free()

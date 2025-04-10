extends CharacterBody2D

@onready var path_follow = get_parent()
@onready var animated_sprite = $AnimatedSprite

# Новые переменные
var money: int
var ticket_price: int
var popularity_change: int

# Сгенерировать случайные характеристики
func _ready():
	money = randi() % 100 + 50  # Случайное количество денег (от 50 до 150)
	ticket_price = randi() % 20 + 5  # Случайная стоимость билета (от 5 до 25)
	popularity_change = randi() % 5 - 2  # Случайное изменение популярности (от -2 до 2)

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
		apply_impact_on_popularity()  # Влияние на популярность при выходе
		queue_free()

# Метод для применения воздействия на популярность и деньги
func apply_impact_on_popularity():
	Global.add_money(ticket_price)
	Global.add_popularity(popularity_change)

extends CharacterBody2D
class_name Human

@onready var path_follow = get_parent()
@onready var animated_sprite = $AnimatedSprite

var initial_money: int
var ticket_price: int
@export var favorite_animal: String
var seen_animals: Dictionary = {
	"Bear": 0,
	"Rabbit": 0,
	"Picachy": 0,
	"Lion": 0
}

func _ready():
	randomize()
	# Генерация параметров
	initial_money = randi() % 151 + 50  # 50-200
	ticket_price = randi() % 41 + 10    # 10-50
	favorite_animal = ["Bear", "Rabbit", "Picachy", "Lion"][randi() % 4]
	# Оплата билета
	Global.add_money(ticket_price)
	initial_money -= ticket_price
	
	
	print("Новый посетитель:")
	print("Денег: ", initial_money)
	print("Его цена билета: ", ticket_price)
	print("Любимое животное: ", favorite_animal)

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
		print("Итоговые увиденные животные: ", seen_animals)
		print("Популярность изменена на: ", popularity_change)
		queue_free()

func add_seen_animal(animal_type: String) -> void:
	if seen_animals.has(animal_type):
		seen_animals[animal_type] += 1
		print("Вошел в зону: ", animal_type, " (всего: ", seen_animals[animal_type], ")")

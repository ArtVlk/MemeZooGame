extends CharacterBody2D

@export var speed := 200.0

var walking := true
var idle := false
var xdir := 1
var ydir := 1
var moving_vertical_horizontal := 1

var border_bounds: Rect2  # Границы движения
@onready var collision_shape = $CollisionShape # Получаем CollisionShape2D

func _ready():
	randomize()
	walking = true
	
	# Найдём TileMap по иерархии
	var border_tilemap = get_parent().get_node_or_null("Border")
	if border_tilemap:
		var used_rect = border_tilemap.get_used_rect()
		var cell_size = border_tilemap.tile_set.tile_size
		var top_left = border_tilemap.map_to_local(used_rect.position)
		var size = used_rect.size * cell_size
		border_bounds = Rect2(top_left, size)
	else:
		push_error("Не найден TileMap с границами вольера!")

func _physics_process(delta: float) -> void:
	if not walking:
		var r = randf_range(1.0, 2.0)
		moving_vertical_horizontal = 1 if r > 1.5 else 2

	if walking:
		$AnimatedSprite.play("walking")
		if moving_vertical_horizontal == 1:
			$AnimatedSprite.flip_h = xdir == -1
			velocity = Vector2(speed * xdir, 0)
		else:
			velocity = Vector2(0, speed * ydir)
	elif idle:
		$AnimatedSprite.play("idle")
		velocity = Vector2.ZERO

	move_and_slide()
	
	# Получаем размеры CollisionShape2D
	var shape = collision_shape.shape
	if shape is RectangleShape2D:
		var shape_extents = shape.extents  # Получаем extents, т.е. половину ширины и высоты

		# Проверка выхода за границы с учетом размеров коллайдера
		if position.x - shape_extents.x < border_bounds.position.x:
			position.x = border_bounds.position.x + shape_extents.x
			xdir = 1
		elif position.x + shape_extents.x > border_bounds.position.x + border_bounds.size.x:
			position.x = border_bounds.position.x + border_bounds.size.x - shape_extents.x
			xdir = -1
		
		if position.y - shape_extents.y < border_bounds.position.y:
			position.y = border_bounds.position.y + shape_extents.y
			ydir = 1
		# Увеличиваем проверку снизу на небольшой отступ
		elif position.y + shape_extents.y > border_bounds.position.y + border_bounds.size.y - 2:  # Отступ на 2 пикселя
			position.y = border_bounds.position.y + border_bounds.size.y - shape_extents.y - 2  # Отступ снизу
			ydir = -1

func _on_walking_timer_timeout() -> void:
	xdir = 1 if randf_range(0, 1) > 0.5 else -1
	ydir = 1 if randf_range(0, 1) > 0.5 else -1
	$WalkingTimer.wait_time = randf_range(1, 4)
	$WalkingTimer.start()

func _on_chage_state_timer_timeout() -> void:
	if walking:
		idle = true
		walking = false
	else:
		idle = false
		walking = true
	$ChageStateTimer.wait_time = randf_range(1, 5)
	$ChageStateTimer.start()

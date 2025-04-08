class_name CageSelectionWindow
extends Panel


func show_with_animation() -> void:
	# Получаем размер вьюпорта
	var viewport_size = get_viewport_rect().size
	# Задаем отступ от нижнего края, например, 20 пикселей
	var bottom_margin: float = 20.0
	# Устанавливаем позицию панели по центру снизу
	position = Vector2(
		(viewport_size.x - size.x) * 0.5,   # Центрирование по X
		viewport_size.y - size.y - bottom_margin  # Сдвиг к нижней части экрана
	)
	
	show()  # Делаем панель видимой
	if has_node("AnimationPlayer"):
		$AnimationPlayer.play("show_panel")

# Метод для скрытия панели (здесь можно добавить анимацию скрытия, если потребуется)
func hide_panel() -> void:
	hide()

# Методы, привязанные к кнопкам панели через сигнал pressed.
# Они пробрасывают вызов в GameScene, где реализована логика спавна.
func _on_bear_button_pressed() -> void:
	get_tree().current_scene._on_select_bear_cage_button_pressed()

func _on_rabbit_button_pressed() -> void:
	get_tree().current_scene._on_select_rabbit_cage_button_pressed()

func _on_picachy_button_pressed() -> void:
	get_tree().current_scene._on_select_picachy_cage_button_pressed()

func _on_lion_button_pressed() -> void:
	get_tree().current_scene._on_select_lion_cage_button_pressed()

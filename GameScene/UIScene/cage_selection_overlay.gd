extends Control

@onready var cage_window = $CageSelectionWindow

func _ready() -> void:
	# Контроль перехвата ввода на всей области overlay
	mouse_filter = Control.MOUSE_FILTER_STOP

# Обработка клавиши Esc, если окно активно
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		hide_overlay()

# Обработка кликов мыши по всему overlay
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		# Пересчитываем координаты клика относительно окна выбора
		var local_pos = cage_window.get_global_transform().affine_inverse().xform(get_global_mouse_position())
		# Если клик не попал в область окна выбора, закрываем overlay
		if not cage_window.get_rect().has_point(local_pos):
			hide_overlay()

# Метод для скрытия overlay (закрытия окна выбора)
func hide_overlay() -> void:
	hide()
	# Дополнительно можно сбросить активный спавнер в GameScene
	if get_tree().current_scene.has_method("reset_active_spawner"):
		get_tree().current_scene.reset_active_spawner()

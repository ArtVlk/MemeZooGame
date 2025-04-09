class_name GameScene
extends Node2D

@export var bear_cage_scene: PackedScene
@export var rabbit_cage_scene: PackedScene
@export var picachy_cage_scene: PackedScene
@export var lion_cage_scene: PackedScene

const PRICE_BEAR_CAGE: int = 500
const PRICE_RABBIT_CAGE: int = 250
const PRICE_PICACHY_CAGE: int = 350
const PRICE_LION_CAGE: int = 700

var active_spawner: Area2D = null

func _ready() -> void:
	set_process_unhandled_input(true)

# Обработка клавиши Esc на уровне сцены
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		var overlay = $UI/CageSelectionOverlay
		if overlay.visible:
			overlay.hide_overlay()

# Метод для показа окна выбора клетки с передачей текущего спавнера
func show_cage_selection_window(spawner: Area2D) -> void:
	active_spawner = spawner
	var overlay = $UI/CageSelectionOverlay
	overlay.show()  # Показываем overlay, который занимает весь экран
	# Запускаем анимацию открытия окна, если таковая имеется
	if overlay.has_node("CageSelectionWindow"):
		overlay.get_node("CageSelectionWindow").show_with_animation()

# Функция для проверки достаточного количества денег и списания денег
func try_purchase(price: int) -> bool:
	if Global.money >= price:
		Global.add_money(-price)
		return true
	else:
		print("Недостаточно средств! Требуется", price, "а у вас", Global.money)
		return false

# Методы, вызываемые по нажатию на кнопки выбора:
func _on_select_bear_cage_button_pressed() -> void:
	print("Выбрана клетка Bear")
	if active_spawner:
		if try_purchase(PRICE_BEAR_CAGE):
			active_spawner.spawn_cage(bear_cage_scene)
	active_spawner = null
	$UI/CageSelectionOverlay.hide_overlay()

func _on_select_rabbit_cage_button_pressed() -> void:
	print("Выбрана клетка Rabbit")
	if active_spawner:
		if try_purchase(PRICE_RABBIT_CAGE):
			active_spawner.spawn_cage(rabbit_cage_scene)
	active_spawner = null
	$UI/CageSelectionOverlay.hide_overlay()
	
func _on_select_picachy_cage_button_pressed() -> void:
	print("Выбрана клетка Picachy")
	if active_spawner:
		if try_purchase(PRICE_PICACHY_CAGE):
			active_spawner.spawn_cage(picachy_cage_scene)
	active_spawner = null
	$UI/CageSelectionOverlay.hide_overlay()

func _on_select_lion_cage_button_pressed() -> void:
	print("Выбрана клетка Lion")
	if active_spawner:
		if try_purchase(PRICE_LION_CAGE):
			active_spawner.spawn_cage(lion_cage_scene)
	active_spawner = null
	$UI/CageSelectionOverlay.hide_overlay()

# Метод для сброса активного спавнера (если нужно)
func reset_active_spawner() -> void:
	active_spawner = null

class_name HighlightTile
extends Node2D

# Размер текстуры спрайта (например, 32x32)
@export var texture_size: Vector2 = Vector2(32, 32)

func _process(delta: float) -> void:
	follow_mouse_position()

func follow_mouse_position() -> void:
	var camera = get_viewport().get_camera_2d()
	if camera:
		position = get_global_mouse_position()
		var desired_size = Vector2(32, 32)
		var scale_factor = desired_size / texture_size  # для (32,32) даст (2,2)
		# Компенсируем зум: умножаем на camera.zoom, а не делим
		scale = Vector2(scale_factor.x * camera.zoom.x, scale_factor.y * camera.zoom.y)
	else:
		position = get_global_mouse_position()
		scale = Vector2.ONE

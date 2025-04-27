extends Node2D

@export var animal_type: String = "Unknown"  # Тип животного в вольере


func _ready():
	# Убедитесь, что вольер имеет Area2D для обнаружения
	if not $DetectionArea:
		push_error("Не найдена DetectionArea в вольере!")

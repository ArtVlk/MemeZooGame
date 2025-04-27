extends Node2D

@export var animal_type: String = "Bear"  # Тип животного в вольере
@onready var detection_area = $DetectionArea

func _ready():
	if detection_area:
		detection_area.connect("body_entered", Callable(self, "_on_detection_area_entered"))
	else:
		push_error("DetectionArea не найдена в вольере!")

func _on_detection_area_entered(body):
	if body is Human:
		body.add_seen_animal(animal_type)
		print("Посетитель вошел в вольер с ", animal_type)

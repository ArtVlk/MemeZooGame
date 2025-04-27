extends Control

@onready var back_button = $VBoxContainer/BackButton

const SAVE_PATH = "user://settings.cfg"

# Обработчик нажатия на кнопку "Back"
func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://MenuScene/MainMenu.tscn")

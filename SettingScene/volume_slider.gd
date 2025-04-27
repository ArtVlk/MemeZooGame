extends HSlider

@export 
var bus_name: String

var bus_index: int

func _ready() -> void:
	# Инициализация слайдера текущей громкостью
	value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus_name)))
	value_changed.connect(_on_value_changed)

func _on_value_changed(new_value: float) -> void:
	var volume_db = linear_to_db(new_value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), volume_db)
	
	# Обновляем громкость текущей музыки (если нужно)
	MusicManager.set_volume(volume_db)

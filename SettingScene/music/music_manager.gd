extends Node

# Путь к аудиофайлу
const MUSIC_PATH = "res://SettingScene/music/Monkeys.mp3"

var audio_player: AudioStreamPlayer

func _ready() -> void:
	# Создаем аудиоплеер и добавляем его в сцену
	audio_player = AudioStreamPlayer.new()
	audio_player.stream = load(MUSIC_PATH)
	add_child(audio_player)
	
	# Начинаем воспроизведение
	play_music()

func play_music() -> void:
	if not audio_player.playing:
		audio_player.play()

func stop_music() -> void:
	audio_player.stop()

func set_volume(db: float) -> void:
	audio_player.volume_db = db

extends PanelContainer

@onready var money_label: Label = $VBoxContainer/MoneyLabel
@onready var popularity_label: Label = $VBoxContainer/PopularityLabel

func _ready() -> void:
	update_ui()

# Метод обновления информации в HUD
func update_ui() -> void:
	money_label.text = "Деньги: " + str(Global.money)
	popularity_label.text = "Популярность: " + str(Global.popularity)
	
func _process(delta: float) -> void:
	update_ui()

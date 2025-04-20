extends Node


var money: int = 1000
var popularity: int = 10

func add_money(amount: int) -> void:
	money += amount


func remove_money(amount: int) -> void:
	if amount > 0 and money >= amount:
		money -= amount
	else:
		money = 0

func add_popularity(amount: int) -> void:
	popularity += amount

func remove_popularity(amount: int) -> void:
	if amount > 0 and popularity >= amount:
		popularity -= amount
	else:
		popularity = 0

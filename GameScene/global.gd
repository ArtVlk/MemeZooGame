extends Node


var money: int = 1000
var popularity: int = 10

func add_money(amount: int) -> void:
	money += amount


func remove_money(amount: int) -> void:
	money -= amount

func add_popularity(amount: int) -> void:
	popularity += amount

func remove_popularity(amount: int) -> void:
	popularity -= amount

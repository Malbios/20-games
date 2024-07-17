class_name Houses extends Node2D

signal all_houses_destroyed

var house_count := 0


func on_house_destroyed():
	if house_count == 0:
		return

	house_count -= 1
	if house_count > 0:
		return

	all_houses_destroyed.emit()


func _ready():
	for child in get_children():
		var house = child as House
		house_count += 1
		house.destroyed.connect(on_house_destroyed)

class_name HeartsCounter extends Node2D

signal no_hearts_left

@onready var hearts := [$Heart1, $Heart2, $Heart3]


func decrease():
	if hearts.size() == 0:
		return

	var heart = hearts.pop_back()
	heart.queue_free()

	if hearts.size() == 0:
		no_hearts_left.emit()

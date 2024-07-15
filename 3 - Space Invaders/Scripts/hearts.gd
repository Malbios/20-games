class_name HeartsCounter extends Node2D

signal all_hearts_gone

@onready var hearts := [$Heart1, $Heart2, $Heart3]


func decrease():
	if hearts.size() == 0:
		print("this should not have happened")
		return

	var heart = hearts.pop_back()
	heart.queue_free()

	if hearts.size() == 0:
		all_hearts_gone.emit()
		queue_free()

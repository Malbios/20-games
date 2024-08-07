class_name GameScene extends Node2D


func custom_input():
	if Input.is_action_just_released("restart"):
		get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _ready():
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_RESIZE_DISABLED, true)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(_event):
	if Input.is_action_pressed("toggle_fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		elif DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	if Input.is_action_just_released("quit"):
		get_tree().quit()

	custom_input()

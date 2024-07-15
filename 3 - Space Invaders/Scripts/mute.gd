class_name MuteHandler extends Node

var muted := false


func is_muted():
	return muted


func _input(_event):
	if Input.is_action_just_released("mute"):
		print("toggle mute")
		muted = not muted

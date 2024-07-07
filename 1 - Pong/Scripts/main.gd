extends Node

@export var player_gadget: CharacterBody2D
@export var bot_gadget: CharacterBody2D
@export var ball_gadget: CharacterBody2D

var round_started = false

# Called when the node enters the scene tree for the first time.
func _ready():
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_RESIZE_DISABLED, true)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	player_gadget.set_process(false)
	bot_gadget.set_process(false)
	ball_gadget.set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("ui_cancel"):
		get_tree().quit()

	if not round_started and Input.is_action_just_released("restart"):
		player_gadget.set_process(true)
		bot_gadget.set_process(true)
		ball_gadget.set_process(true)

		ball_gadget.show()
		$StartHint.hide()

		round_started = true

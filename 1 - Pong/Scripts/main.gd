extends Node

@export var ball_speed = 400

@export var player: CharacterBody2D
@export var bot: CharacterBody2D
@export var player_score: Label
@export var bot_score: Label

var player_score_value := 0
var bot_score_value := 0

var ball_prefab := preload("res://Scenes/ball.tscn")
var bounce_sound := preload("res://Assets/bounce.wav")
var player_scored_sound := preload("res://Assets/player_scored.wav")
var bot_scored_sound := preload("res://Assets/bot_scored.wav")

var bounce_sound_player := AudioStreamPlayer.new()
var player_scored_sound_player := AudioStreamPlayer.new()
var bot_scored_sound_player := AudioStreamPlayer.new()

var ball: RigidBody2D

var initial_player_position
var initial_bot_position

var running_match := false


func set_elements_process(enabled: bool):
	player.set_process(enabled)
	player.set_physics_process(enabled)
	bot.set_process(enabled)
	bot.set_physics_process(enabled)


func reset_ball():
	if is_instance_valid(ball):
		ball.queue_free()

	ball = ball_prefab.instantiate()
	ball.body_entered.connect(handle_ball_collision)
	add_child(ball)
	var force_vector = Vector2(randf_range(-0.8, 0.8), randf_range(-0.3, 0.3)).normalized()
	force_vector *= ball_speed
	ball.apply_impulse(force_vector)


func set_game_elements(enable: bool):
	if enable:
		$StartHint.hide()
		set_elements_process(true)
		player_score_value = 0
		player_score.text = str(player_score_value)
		bot_score_value = 0
		bot_score.text = str(bot_score_value)
		reset_ball()
	else:
		if ball:
			ball.queue_free()
		player.position = initial_player_position
		player.velocity = Vector2.ZERO
		bot.position = initial_bot_position
		bot.velocity = Vector2.ZERO
		set_elements_process(false)
		$StartHint.show()

	running_match = enable


func handle_ball_collision(body: Node):
	if body.name == "WorldBoundaryRight":
		player_scored_sound_player.play()
		player_score_value += 1
		player_score.text = str(player_score_value)
		reset_ball()
	elif body.name == "WorldBoundaryLeft":
		bot_scored_sound_player.play()
		bot_score_value += 1
		bot_score.text = str(bot_score_value)
		reset_ball()
	else:
		bounce_sound_player.play()


func _ready():
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_RESIZE_DISABLED, true)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	bounce_sound_player.stream = bounce_sound
	add_child(bounce_sound_player)
	player_scored_sound_player.stream = player_scored_sound
	add_child(player_scored_sound_player)
	bot_scored_sound_player.stream = bot_scored_sound
	add_child(bot_scored_sound_player)

	initial_player_position = player.position
	initial_bot_position = bot.position

	set_game_elements(false)


func _input(_event):
	if Input.is_action_pressed("toggle_fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		elif DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	if Input.is_action_just_released("quit"):
		get_tree().quit()

	if not running_match and Input.is_action_just_released("restart"):
		set_game_elements(true)
	elif running_match and Input.is_action_just_released("restart"):
		set_game_elements(false)

extends GameScene

const BALL_BOOST = 600

@onready var start_hint_label := $StartHint as Label
@onready var ball := $Ball as Ball
@onready var player := $PlayerPaddle as Player
@onready var hearts_counter := $Hearts as HeartsCounter
@onready var ball_initial_position := ball.position
@onready var player_initial_position := player.position

var audio_player = AudioStreamPlayer.new()
var boing_sound = preload("res://Assets/boing.wav")

var match_running := false
var reboost := false
var bricks_prefab := preload("res://Scenes/Components/bricks.tscn")
var bricks: Bricks

var hearts_prefab := preload("res://Scenes/Components/hearts.tscn")


func boost_ball():
	var force_vector = Vector2(randf_range(-0.5, 0.5), -1).normalized()
	force_vector *= BALL_BOOST
	ball.apply_impulse(force_vector)


func launch_ball():
	ball.freeze = false
	boost_ball()


func setup_node(node: Node2D, enable: bool):
	node.set_process(enable)
	node.set_physics_process(enable)


func reset_bricks():
	if is_instance_valid(bricks):
		bricks.queue_free()

	bricks = bricks_prefab.instantiate()
	bricks.all_bricks_gone.connect(on_all_bricks_gone)
	bricks.position = Vector2(0, -10)
	add_child(bricks)


func reset_hearts():
	var counter_position = hearts_counter.position

	if is_instance_valid(hearts_counter):
		hearts_counter.queue_free()

	hearts_counter = hearts_prefab.instantiate()
	hearts_counter.no_hearts_left.connect(on_no_hearts_left)
	hearts_counter.position = counter_position
	add_child(hearts_counter)


func setup(enable: bool):
	if enable:
		setup_node(player, true)
		setup_node(ball, true)
		start_hint_label.hide()
		launch_ball()
	else:
		reset_hearts()
		reset_bricks()
		player.reset_size()
		start_hint_label.show()
		setup_node(player, false)
		setup_node(ball, false)
		player.position = player_initial_position
		ball.call_deferred("reset_position", ball_initial_position)

	match_running = enable


func on_ball_fell_down():
	hearts_counter.decrease()


func on_ball_reached_ceiling():
	player.shrink()


func on_ball_hit_player():
	if not reboost:
		return

	reboost = false
	player.set_color_default()

	boost_ball()


func on_ball_hit_something():
	if Mute.is_muted():
		return

	audio_player.play()


func on_all_bricks_gone():
	get_tree().change_scene_to_file("res://Scenes/winner.tscn")


func on_no_hearts_left():
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")


func custom_input():
	if not Input.is_action_just_released("restart"):
		return

	if not match_running:
		setup(true)
		return

	player.set_color_red()
	reboost = true


func _ready():
	super()

	audio_player.stream = boing_sound
	audio_player.volume_db = 0.6
	audio_player.pitch_scale = 1
	add_child(audio_player)

	ball.fell_down.connect(on_ball_fell_down)
	ball.reached_ceiling.connect(on_ball_reached_ceiling)
	ball.hit_player.connect(on_ball_hit_player)
	ball.hit_something.connect(on_ball_hit_something)

	setup(false)
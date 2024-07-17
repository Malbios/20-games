extends GameScene

@export var mothership_prefab: PackedScene
@export var chair_prefab: PackedScene

@onready var aliens := $Aliens as Aliens
@onready var mothership_timer = $MothershipTimer as Timer
@onready var player := $Player as Player
@onready var hearts := $Hearts as HeartsCounter
@onready var houses := $Houses as Houses


func spawn_mothership():
	var mothership = mothership_prefab.instantiate()
	mothership.position = Vector2(-360, -360)
	mothership.scale = Vector2(6, 6)
	mothership.was_hit.connect(on_mothership_hit)
	get_tree().current_scene.add_child(mothership)


func spawn_chair():
	var chair = chair_prefab.instantiate()
	chair.position = Vector2(268, 275)
	chair.scale = Vector2(6, 6)
	get_tree().current_scene.add_child(chair)


func on_mothership_timer():
	spawn_mothership()


func on_mothership_hit():
	ScoreTracker.score += 10


func on_alien_hit():
	ScoreTracker.score += 1


func on_player_hit():
	hearts.decrease()


func on_player_final_death():
	await get_tree().create_timer(1.0).timeout
	Constants.change_scene(get_tree(), "res://Scenes/game_over.tscn")


func on_all_aliens_dead():
	await get_tree().create_timer(1.0).timeout
	Constants.change_scene(get_tree(), "res://Scenes/win.tscn")


func on_aliens_at_base():
	await get_tree().create_timer(1.0).timeout
	Constants.change_scene(get_tree(), "res://Scenes/game_over.tscn")


func on_all_houses_destroyed():
	await get_tree().create_timer(1.0).timeout
	Constants.change_scene(get_tree(), "res://Scenes/game_over.tscn")


func _ready():
	super()

	player.was_hit.connect(on_player_hit)
	hearts.all_hearts_gone.connect(on_player_final_death)
	aliens.all_aliens_dead.connect(on_all_aliens_dead)
	aliens.aliens_at_base.connect(on_aliens_at_base)
	aliens.alien_was_hit.connect(on_alien_hit)
	houses.all_houses_destroyed.connect(on_all_houses_destroyed)
	mothership_timer.timeout.connect(on_mothership_timer)
	spawn_chair()
	mothership_timer.start()

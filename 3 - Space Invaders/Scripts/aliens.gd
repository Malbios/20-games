class_name Aliens extends Node2D

const SPEED = 100.0

const RIGHT_DIRECTION = Vector2(1, 0)
const LEFT_DIRECTION = Vector2(-1, 0)

var direction := RIGHT_DIRECTION

var ignore_collisions := false
var timer: Timer


func on_collision(_collider_name: String):
	if ignore_collisions:
		return

	set_ignore_collisions()

	if direction == LEFT_DIRECTION:
		direction = RIGHT_DIRECTION
	elif direction == RIGHT_DIRECTION:
		direction = LEFT_DIRECTION

	for child in get_children():
		var alien = child as Alien
		alien.direction = direction
		alien.position = alien.position + Vector2(0, 10)


func set_ignore_collisions():
	ignore_collisions = true
	timer = Timer.new()
	timer.wait_time = 1.0
	timer.one_shot = true
	timer.autostart = true
	timer.timeout.connect(on_timeout)
	get_tree().current_scene.add_child(timer)


func on_timeout():
	ignore_collisions = false
	timer.queue_free()


func start_game():
	for child in get_children():
		var alien = child as Alien
		alien.speed = SPEED


func _ready():
	for child in get_children():
		var alien = child as Alien
		alien.collision_with.connect(on_collision)
		alien.direction = direction
		alien.speed = 0

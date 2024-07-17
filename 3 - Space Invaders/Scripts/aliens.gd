class_name Aliens extends Node2D

signal all_aliens_dead
signal aliens_at_base
signal alien_was_hit

const SPEED = 100.0

const RIGHT_DIRECTION = Vector2(1, 0)
const LEFT_DIRECTION = Vector2(-1, 0)

var direction := RIGHT_DIRECTION

var ignore_collisions := false
var timer: Timer
var aliens_count := 0


func on_alien_death():
	alien_was_hit.emit()
	aliens_count -= 1

	if aliens_count == 0:
		all_aliens_dead.emit()


func on_collision(body: Node):
	if ignore_collisions:
		return

	set_ignore_collisions()

	# var collider_name := str(body.get("name"))
	# print("an alien collided with " + collider_name)

	if body is House:
		aliens_at_base.emit()
		return

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


func _ready():
	for child in get_children():
		var alien = child as Alien
		aliens_count += 1
		alien.collision_with.connect(on_collision)
		alien.died.connect(on_alien_death)
		alien.direction = direction
		alien.speed = SPEED

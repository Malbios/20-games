class_name Alien extends CharacterBody2D

signal collision_with(body: Node)
signal died

@export var explosion_effect: PackedScene

@onready var anim := $AnimatedSprite2D as AnimatedSprite2D

var timer = Timer.new()

var speed: float
var direction: Vector2


func hit(projectile: Projectile):
	if projectile.shooter == Constants.ShooterKind.Alien:
		return

	Constants.explode(self)
	queue_free()
	died.emit()


func get_timer_wait_time():
	return randf_range(2.0, 8.0)


func has_alien_below():
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(
		global_position, global_position + Vector2(0, 100)
	)
	query.exclude = [self]

	var result = space_state.intersect_ray(query)

	if not result.has("collider"):
		return false

	var collider = result.collider
	if collider is Alien:
		return true

	return false


func fire():
	Constants.fire_projectile(
		get_tree().current_scene,
		Constants.ShooterKind.Alien,
		global_position + Vector2(0, 30),
		Vector2(0, 1),
		500
	)


func on_timer_finished():
	if not has_alien_below():
		fire()
	timer.wait_time = get_timer_wait_time()
	timer.start()


func _ready():
	anim.play()
	timer.wait_time = get_timer_wait_time()
	timer.one_shot = true
	timer.timeout.connect(on_timer_finished)
	add_child(timer)
	timer.start()


func _physics_process(delta):
	var collision = move_and_collide(direction * speed * delta)
	if not collision:
		return

	collision_with.emit(collision.get_collider())

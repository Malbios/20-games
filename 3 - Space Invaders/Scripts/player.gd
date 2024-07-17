class_name Player extends CharacterBody2D

signal hit_alien
signal hit_mothership
signal was_hit

@export var projectile_prefab: PackedScene

@onready var anim_player = $AnimationPlayer as AnimationPlayer

var timer = Timer.new()

const MIN_X = -260
const MAX_X = 260

const SPEED = 600.0
const ACCELERATION = 10.0


func hit(projectile: Projectile):
	if projectile.shooter == Constants.ShooterKind.Player:
		return

	Constants.explode(self)
	was_hit.emit()


func _ready():
	timer.wait_time = 1.0
	timer.one_shot = true
	add_child(timer)


func _input(_event: InputEvent):
	if not is_physics_processing():
		return

	if timer.time_left > 0:
		return

	if Input.is_action_just_released("fire"):
		Constants.fire_projectile(
			get_tree().current_scene,
			Constants.ShooterKind.Player,
			global_position + Vector2(0, -30),
			Vector2(0, -1),
			750
		)
		timer.start()


func _physics_process(delta: float):
	if Input.is_action_pressed("left"):
		velocity = lerp(velocity, Vector2(-1, 0) * SPEED, delta * ACCELERATION)
	elif Input.is_action_pressed("right"):
		velocity = lerp(velocity, Vector2(1, 0) * SPEED, delta * ACCELERATION)
	else:
		velocity = Vector2.ZERO

	move_and_slide()

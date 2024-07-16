class_name Player extends CharacterBody2D

@export var projectile: PackedScene

@onready var anim_player = $AnimationPlayer as AnimationPlayer
@onready var timer = $Timer as Timer

const MIN_X = -260
const MAX_X = 260

const SPEED = 600.0
const ACCELERATION = 10.0


func _input(_event: InputEvent):
	if not is_physics_processing():
		return

	if timer.time_left > 0:
		return

	if Input.is_action_just_released("fire"):
		Constants.fire_projectile(
			get_tree().current_scene,
			Constants.ShooterKind.Player,
			position + Vector2(0, -30),
			Vector2(0, -1)
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

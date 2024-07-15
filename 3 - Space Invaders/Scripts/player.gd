class_name Player extends CharacterBody2D

@onready var anim_player = $AnimationPlayer as AnimationPlayer

const MIN_X = -260
const MAX_X = 260

const SPEED = 600.0
const ACCELERATION = 10.0


func fire():
	pass


func _input(_event: InputEvent):
	if Input.is_action_just_released("fire"):
		fire()

	if Input.is_action_pressed("left"):
		pass
	elif Input.is_action_pressed("right"):
		pass


func _physics_process(delta: float):
	if Input.is_action_pressed("left"):
		velocity = lerp(velocity, Vector2(-1, 0) * SPEED, delta * ACCELERATION)
	elif Input.is_action_pressed("right"):
		velocity = lerp(velocity, Vector2(1, 0) * SPEED, delta * ACCELERATION)
	else:
		velocity = Vector2.ZERO

	move_and_slide()

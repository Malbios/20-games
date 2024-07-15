extends CharacterBody2D

@onready var anim := $AnimatedSprite2D as AnimatedSprite2D

const SPEED = 300.0
const ACCELERATION = 10.0

const RIGHT_DIRECTION = Vector2(1, 0)
const LEFT_DIRECTION = Vector2(-1, 0)

var direction := RIGHT_DIRECTION

var collisions := 3


func on_collision():
	if direction == LEFT_DIRECTION:
		direction = RIGHT_DIRECTION
	elif direction == RIGHT_DIRECTION:
		direction = LEFT_DIRECTION

	collisions -= 1

	if collisions == 0:
		queue_free()


func _ready():
	anim.play()


func _physics_process(delta):
	velocity = lerp(velocity, direction * SPEED, delta * ACCELERATION)

	if move_and_slide():
		on_collision()

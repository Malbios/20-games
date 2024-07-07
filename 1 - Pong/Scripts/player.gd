extends CharacterBody2D

const SPEED = 300.0

func _physics_process(delta: float):
	if Input.is_action_pressed(("up")):
		velocity.y -= SPEED * delta

	if Input.is_action_pressed("down"):
		velocity.y += SPEED * delta

	move_and_slide()

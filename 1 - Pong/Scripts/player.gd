extends CharacterBody2D

var speed: float = 800.0
var acceleration: float = 2.0


func _physics_process(delta: float):
	if Input.is_action_pressed("break"):
		velocity = Vector2.ZERO
	else:
		var mouse_velocity = Input.get_last_mouse_velocity().normalized()
		velocity = lerp(velocity, Vector2(0, mouse_velocity.y) * speed, delta * acceleration)

	move_and_slide()

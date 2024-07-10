class_name Player extends CharacterBody2D

@onready var default_scale := scale
@onready var colored_rectangle := $ColoredRectangle as ColorRect
@onready var default_color := colored_rectangle.self_modulate

var speed := 600.0
var acceleration := 10.0


func shrink():
	if scale.x <= 0.35:
		return

	scale.x -= 0.1


func reset_size():
	scale = default_scale


func set_color_red():
	colored_rectangle.self_modulate = Color.RED


func set_color_default():
	colored_rectangle.self_modulate = default_color


func _physics_process(delta: float):
	var mouse_velocity = Input.get_last_mouse_velocity().normalized()

	if Input.is_action_pressed("left") or mouse_velocity.x < 0:
		velocity = lerp(velocity, Vector2(-1, 0) * speed, delta * acceleration)
	elif Input.is_action_pressed("right") or mouse_velocity.x > 0:
		velocity = lerp(velocity, Vector2(1, 0) * speed, delta * acceleration)
	else:
		velocity = Vector2.ZERO

	move_and_slide()

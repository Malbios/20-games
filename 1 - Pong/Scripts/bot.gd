extends CharacterBody2D

var speed := 800.0
var acceleration := 2.0
var random_direction := Vector2.ZERO

var ai_timer := Timer.new()


func on_timer():
	random_direction = Vector2(0, randf_range(-1, 1)).normalized()
	ai_timer.start(1)


func _ready():
	ai_timer.timeout.connect(on_timer)
	add_child(ai_timer)
	ai_timer.start(1)


func _physics_process(delta: float):
	velocity = lerp(velocity, random_direction * speed, delta * acceleration)

	move_and_slide()

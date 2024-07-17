class_name Projectile extends Area2D

signal hit_something(shooter: Constants.ShooterKind, body: Node)

@onready var sound := $AudioStreamPlayer as AudioStreamPlayer

var speed: int
var direction: Vector2
var shooter: Constants.ShooterKind


func hit(projectile: Projectile):
	if shooter != projectile.shooter:
		queue_free()


func on_body_entered(body: Node):
	if body.has_method("hit"):
		body.hit(self)
		hit_something.emit(shooter, body)

	queue_free()


func _ready():
	body_entered.connect(on_body_entered)
	if not Mute.muted:
		sound.play()


func _physics_process(delta):
	position += direction * speed * delta

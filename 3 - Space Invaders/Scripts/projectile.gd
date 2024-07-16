class_name Projectile extends Area2D

signal hit_something(body: Node)

var speed := 750
var direction := Vector2(0, -1)

var shooter: Constants.ShooterKind


func on_body_entered(body: Node):
	if body.has_method("hit"):
		body.hit(self)
		hit_something.emit(body)

	queue_free()


func _ready():
	body_entered.connect(on_body_entered)


func _physics_process(delta):
	position += direction * speed * delta

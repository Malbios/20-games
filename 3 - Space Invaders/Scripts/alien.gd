class_name Alien extends CharacterBody2D

signal collision_with(collider_name: String)

@export var explosion_effect: PackedScene

@onready var anim := $AnimatedSprite2D as AnimatedSprite2D

var speed: float
var direction: Vector2


func hit(projectile: Projectile):
	if projectile.shooter == Constants.ShooterKind.Alien:
		return

	Constants.explode(self)
	queue_free()


func _ready():
	anim.play()


func _physics_process(delta):
	var collision = move_and_collide(direction * speed * delta)
	if not collision:
		return

	var collider_name := str(collision.get_collider().get("name"))
	collision_with.emit(collider_name)

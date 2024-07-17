class_name House extends StaticBody2D

signal destroyed

@onready var anim := $AnimatedSprite2D as AnimatedSprite2D

var hitpoints := 3


func hit(projectile: Projectile):
	if hitpoints == 0:
		return

	if projectile.shooter == Constants.ShooterKind.Player:
		return

	Constants.explode(self)
	hitpoints -= 1
	ScoreTracker.score -= 1

	match hitpoints:
		2:
			anim.frame = 1
		1:
			anim.frame = 2
		0:
			anim.animation = "destroyed"
			anim.frame = 0
			anim.play()
			destroyed.emit()

class_name Brick extends StaticBody2D

signal was_hit(brick: Brick, body: Node)

@onready var area := $Area2D as Area2D


func on_collision(body: Node):
	if body is Brick:
		return

	was_hit.emit(self, body)


func _ready():
	area.body_entered.connect(on_collision)

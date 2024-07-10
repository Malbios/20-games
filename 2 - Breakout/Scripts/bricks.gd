class_name Bricks extends Node2D

signal all_bricks_gone

var counter := 0
var bricks_count := 0


func on_brick_was_hit(brick: Brick, _body: Node):
	brick.queue_free()
	counter += 1
	if counter == bricks_count:
		all_bricks_gone.emit()


func _ready():
	for node in get_children():
		if node is Brick:
			bricks_count += 1
			(node as Brick).was_hit.connect(on_brick_was_hit)

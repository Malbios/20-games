class_name Effect2D extends GPUParticles2D

@onready var sound = $AudioStreamPlayer2D as AudioStreamPlayer2D


func on_finish():
	queue_free()


func play(parent: Node2D):
	position = parent.global_position
	rotation = parent.global_rotation
	parent.get_tree().current_scene.add_child(self)
	sound.finished.connect(on_finish)
	emitting = true
	sound.play()

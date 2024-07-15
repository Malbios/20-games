class_name Chair extends StaticBody2D

@export var explosion_effect: PackedScene

@onready var collision_shape = $CollisionShape2D as CollisionShape2D

# katze aus dem haus und spuckt ein alien mit glibber an (grün), katze ist grau
# numpad 4 8 6 für schussrichtung


func on_timeout():
	self.visible = !self.visible
	collision_shape.disabled = !self.visible

	if not self.visible:
		(explosion_effect.instantiate() as Effect2D).play(self)


# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	timer.wait_time = 2.0
	timer.one_shot = false
	timer.autostart = true
	timer.timeout.connect(on_timeout)
	add_child(timer)

extends RigidBody2D


func has_top_speed(top_speed: int):
	if linear_velocity.x > top_speed:
		return true

	if linear_velocity.x < -top_speed:
		return true

	if linear_velocity.y > top_speed:
		return true

	if linear_velocity.y < -top_speed:
		return true

	return false


func on_collision(_body: Node):
	if has_top_speed(800):
		return

	var bounce_boost_norm = linear_velocity.normalized() * 50
	apply_impulse(bounce_boost_norm)


func _ready():
	contact_monitor = true
	max_contacts_reported = 1
	body_entered.connect(on_collision)

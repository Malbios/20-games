class_name Ball extends RigidBody2D

signal fell_down
signal reached_ceiling
signal hit_player
signal hit_something

const TOP_SPEED = 800
const BOUNCE_BOOST = 60

var reset_state = false
var new_position: Vector2


func reset_position(target_position: Vector2):
	new_position = target_position
	reset_state = true


func on_collision(body: Node):
	if freeze:
		return

	hit_something.emit()

	if body.name == "WorldBoundaryBottom":
		fell_down.emit()
	elif body.name == "WorldBoundaryTop":
		reached_ceiling.emit()
	elif body.name == "PlayerPaddle":
		hit_player.emit()

	if linear_velocity.length() >= TOP_SPEED:
		linear_velocity = linear_velocity.normalized() * TOP_SPEED
		return

	var boost = BOUNCE_BOOST
	if body.name == "PlayerPaddle":
		boost *= 2

	var bounce_boost = linear_velocity.normalized() * boost
	apply_impulse(bounce_boost)


func _ready():
	contact_monitor = true
	max_contacts_reported = 1
	body_entered.connect(on_collision)


func _integrate_forces(state: PhysicsDirectBodyState2D):
	if not reset_state:
		return

	freeze = true
	state.transform = Transform2D(0.0, new_position)
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	reset_state = false

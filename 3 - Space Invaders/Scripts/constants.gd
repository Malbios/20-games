class_name Constants

static var projectile_prefab = preload("res://Components/projectile.tscn")
static var explosion_prefab = preload("res://Effects/explosion.tscn")

enum ShooterKind { Player, Alien }


static func fire_projectile(
	current_scene: Node, shooter: ShooterKind, position: Vector2, direction: Vector2, speed: int
):
	var fired_projectile = projectile_prefab.instantiate() as Projectile
	fired_projectile.direction = direction
	fired_projectile.shooter = shooter
	fired_projectile.position = position
	fired_projectile.speed = speed
	current_scene.add_child(fired_projectile)


static func explode(body: Node):
	(explosion_prefab.instantiate() as Effect2D).play(body)


static func change_scene(scene_tree: SceneTree, new_scene: String):
	scene_tree.change_scene_to_file(new_scene)

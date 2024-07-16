extends GameScene

@export var mothership_prefab: PackedScene
@export var chair_prefab: PackedScene

@onready var start_hint := $StartHint as Label
@onready var aliens := $Aliens as Aliens
@onready var mothership_timer = $MothershipTimer as Timer


func spawn_mothership():
	var mothership = mothership_prefab.instantiate()
	mothership.position = Vector2(-360, -360)
	mothership.scale = Vector2(6, 6)
	get_tree().current_scene.add_child(mothership)


func spawn_chair():
	var chair = chair_prefab.instantiate()
	chair.position = Vector2(268, 275)
	chair.scale = Vector2(6, 6)
	get_tree().current_scene.add_child(chair)


func on_mothership_timer():
	spawn_mothership()


func _ready():
	mothership_timer.timeout.connect(on_mothership_timer)


func _input(event: InputEvent):
	super(event)

	if start_hint.visible and Input.is_action_just_released("start"):
		start_hint.visible = false
		aliens.start_game()
		spawn_chair()
		mothership_timer.start()

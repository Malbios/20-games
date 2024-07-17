extends GameScene


func _input(event: InputEvent):
	super(event)

	if Input.is_action_just_released("start"):
		Constants.change_scene(get_tree(), "res://Scenes/main.tscn")

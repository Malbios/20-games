extends ColorRect

const GOLDEN_RATIO = 0.618033988749895


func get_random_color():
	var hue = randf_range(0.0, 1.0)
	hue += GOLDEN_RATIO
	return Color.from_hsv(hue, 0.5, 0.95)


func _ready():
	modulate = get_random_color()

extends Label


func _process(_delta):
	if not ScoreTracker or not ScoreTracker.score:
		return

	self.text = str(ScoreTracker.score)

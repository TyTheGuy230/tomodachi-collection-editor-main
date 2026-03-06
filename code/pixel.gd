extends Sprite2D

@export var fade_time := 0.1

func _ready():
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, fade_time)

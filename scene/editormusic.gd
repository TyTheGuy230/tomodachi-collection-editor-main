extends AudioStreamPlayer
@onready var dstheme = $"."
@onready var tdcmusic = $"03_MiiEdit"
@onready var kurumamusic = $"01_TitleScreen"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if dstheme.ds_theme == 2:
		kurumamusic.play()
	else:
		tdcmusic.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

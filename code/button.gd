extends Button
@onready var head = $"../../../body2"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	head.set_head(1)
	head.load_head()


func _on_button_2_pressed() -> void:
	head.set_head(2)
	head.load_head()

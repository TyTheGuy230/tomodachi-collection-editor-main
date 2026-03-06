extends Button
@onready var parts = $"../../../body2"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	parts.set_head(1)
	parts.load_head()


func _on_button_2_pressed() -> void:
	parts.set_head(2)
	parts.load_head()


func _on_button_3_pressed() -> void:
	parts.set_hair(1)
	parts.load_hair()


func _on_button_4_pressed() -> void:
	parts.set_hair(71)
	parts.load_hair()

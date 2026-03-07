extends TextureButton
@onready var fade = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_down() -> void:
	$Click.play()


func _on_pressed() -> void:
	$"Click(1)".play()
	await get_tree().create_timer(0.8).timeout
	get_tree().change_scene_to_file("res://scene/main mii maker.tscn")

extends TextureButton
@onready var parts = $"../../../body2"
@onready var button1 = $"."
@onready var button2 = $head2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	if parts.head_id == 1:
		button1.button_pressed = true
	else:
		button1.button_pressed = false
		
	if parts.head_id == 2:
		button2.button_pressed = true
	else:
		button2.button_pressed = false


func _on_pressed() -> void:
	parts.head_id = 1
	parts.load_head()

func _on_head_2_pressed() -> void:
	parts.head_id = 2
	parts.load_head()

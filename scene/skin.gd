extends TextureButton
@onready var skintone = $"../../../body2"
@onready var button1 = $"."
@onready var button2 = $skin2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_pressed() -> void:
	skintone.set_skin(1)

func _on_skin_2_pressed() -> void:
	skintone.set_skin(2)

func _on_skin_3_pressed() -> void:
	skintone.set_skin(3)

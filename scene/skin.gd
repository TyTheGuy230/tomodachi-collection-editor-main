extends TextureButton
@onready var skintone = $"../../../body"
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
	$"../../../SeMiiEditColor".play()
	
func _on_skin_2_pressed() -> void:
	skintone.set_skin(2)
	$"../../../SeMiiEditColor".play()

func _on_skin_3_pressed() -> void:
	skintone.set_skin(3)
	$"../../../SeMiiEditColor".play()

func _on_skin_6_pressed() -> void:
	skintone.set_skin(4)
	$"../../../SeMiiEditColor".play()

func _on_skin_4_pressed() -> void:
	skintone.set_skin(5)
	$"../../../SeMiiEditColor".play()

func _on_skin_5_pressed() -> void:
	skintone.set_skin(6)
	$"../../../SeMiiEditColor".play()

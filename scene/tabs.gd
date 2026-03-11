extends TextureButton
@export var tab = 1
@onready var tab2 = $headtab2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if tab == 1:
		$".".button_pressed = true
	else:
		$".".button_pressed = false
		
	if tab == 2:
		tab2.button_pressed = true
	else:
		tab2.button_pressed = false


func _on_pressed() -> void:
	tab = 1

func _on_headtab_2_pressed() -> void:
	tab = 2

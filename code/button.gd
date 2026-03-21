extends TextureButton
@onready var parts = $"../../../../body"
@onready var button1 = $"."
@onready var button2 = $head2
@onready var button3 = $head3
@onready var button4 = $head4
@onready var button5 = $head5
@onready var button6 = $head6
@onready var button7 = $head7
@onready var button8 = $head8


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button1.visible = false


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
	
	if parts.head_id == 3:
		button3.button_pressed = true
	else:
		button3.button_pressed = false

	if parts.head_id == 4:
		button4.button_pressed = true
	else:
		button4.button_pressed = false

	if parts.head_id == 5:
		button5.button_pressed = true
	else:
		button5.button_pressed = false
		
	if parts.head_id == 6:
		button6.button_pressed = true
	else:
		button6.button_pressed = false
		
	if parts.head_id == 7:
		button7.button_pressed = true
	else:
		button7.button_pressed = false
		
	if parts.head_id == 8:
		button8.button_pressed = true
	else:
		button8.button_pressed = false


func _on_pressed() -> void:
	parts.head_id = 1
	parts.current_head.position.x = 10000.0
	parts.current_hair.position.x = 0.0
	parts.current_hat.position.x = 0.0
	parts.load_head()
	$"../../../../Featureselect".play()

func _on_head_2_pressed() -> void:
	parts.head_id = 2
	parts.current_hair.position.x = 0.0
	parts.current_hat.position.x = 0.0
	parts.load_head()
	$"../../../../Featureselect".play()


func _on_head_3_pressed() -> void:
	parts.head_id = 3
	parts.current_hair.position.x = 0.065
	parts.current_hat.position.x = 0.065
	parts.load_head()
	$"../../../../Featureselect".play()


func _on_head_4_pressed() -> void:
	parts.head_id = 4
	parts.current_hair.position.x = 0.0
	parts.current_hat.position.x = 0.0
	parts.load_head()
	$"../../../../Featureselect".play()
	

func _on_head_5_pressed() -> void:
	parts.head_id = 5
	parts.current_hair.position.x = 0.0
	parts.current_hat.position.x = 0.0
	parts.load_head()
	$"../../../../Featureselect".play()


func _on_head_6_pressed() -> void:
	parts.head_id = 6
	parts.current_hair.position.x = 0.0
	parts.current_hat.position.x = 0.0
	parts.load_head()
	$"../../../../Featureselect".play()
	
	
func _on_head_7_pressed() -> void:
	parts.head_id = 7
	parts.current_hair.position.x = 0.065
	parts.current_hat.position.x = 0.065
	parts.load_head()
	$"../../../../Featureselect".play()

func _on_head_8_pressed() -> void:
	parts.head_id = 8
	parts.current_hair.position.x = 0.065
	parts.current_hat.position.x = 0.065
	parts.load_head()
	$"../../../../Featureselect".play()

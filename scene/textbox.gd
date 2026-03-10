extends TextureRect
@onready var textbox = $"."
@onready var colorrect = $"../ColorRect/AnimationPlayer"
@onready var back = $"../backbutton"
@onready var genderbutton = $TextureButton
@onready var textboxtext = $Label
@onready var buttons = $"../headbuttons/head1"
@onready var body = $"../../../body2"
@onready var bartext = $"../Label"
@onready var skinbuttons = $"../skin1"
@onready var yes = $backyes
@onready var no = $backno


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textboxtext.text = "Please choose a gender."
	textbox.position.y = 800
	await get_tree().create_timer(0.2).timeout
	var tween = create_tween()
	tween.tween_property(textbox, "position:y", 50, 0.3)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_OUT)
	yes.visible = false
	no.visible = false
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func slide_down():
	await get_tree().create_timer(0.3).timeout
	var tween = create_tween()
	tween.tween_property(textbox, "position:y", 800, 0.3)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_IN)

func _on_texture_button_pressed() -> void:
	$"TextureButton/Click(4)".play()
	slide_down()
	await get_tree().create_timer(0.3).timeout
	colorrect.play("fade out")
	await get_tree().create_timer(0.45).timeout
	buttons.visible = true
	body.visible = true
	bartext.visible = true
	skinbuttons.visible = true
	back.visible = true

func _on_backbutton_pressed() -> void:
	colorrect.play("fade in")
	var tween = create_tween()
	tween.tween_property(textbox, "position:y", 50, 0.3)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_OUT)
	genderbutton.visible = false
	textboxtext.text = "Are you sure you want to quit?"
	buttons.visible = false
	body.visible = false
	bartext.visible = false
	skinbuttons.visible = false
	back.visible = false
	yes.visible = true
	no.visible = true


func _on_backbutton_button_down() -> void:
	$"../backbutton/Holddown".play()


func _on_backno_pressed() -> void:
	$"TextureButton/Click(4)".play()
	slide_down()
	await get_tree().create_timer(0.2).timeout
	colorrect.play("fade out")
	await get_tree().create_timer(0.4).timeout
	buttons.visible = true
	body.visible = true
	bartext.visible = true
	skinbuttons.visible = true
	back.visible = true
	

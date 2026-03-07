extends TextureRect
@onready var textbox = $"."
@onready var colorrect = $"../ColorRect/AnimationPlayer"
@onready var buttons = $"../headbuttons/head1"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textbox.position.y = 800
	await get_tree().create_timer(0.2).timeout
	var tween = create_tween()
	tween.tween_property(textbox, "position:y", 50, 0.4)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_OUT)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func slide_down():
	await get_tree().create_timer(0.5).timeout
	var tween = create_tween()
	tween.tween_property(textbox, "position:y", 800, 0.4)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_IN)

func _on_texture_button_pressed() -> void:
	slide_down()
	await get_tree().create_timer(0.5).timeout
	colorrect.play("fade out")
	await get_tree().create_timer(0.45).timeout
	buttons.visible = true

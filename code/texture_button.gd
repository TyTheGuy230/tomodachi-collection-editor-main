extends TextureButton
@onready var node3d = $"../../.."
@onready var fade = $"../ColorRect/AnimationPlayer"
@onready var newmii = $"."
@onready var newmiitext = $Label2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if node3d.ds_theme == 2:
		newmii.texture_normal = preload("res://img/sprites/newmiikuruma.png")
		newmii.texture_pressed = preload("res://img/sprites/newmiikurumayellow.png")
		newmiitext.visible = false
		newmii.scale = Vector2(0.8, 0.8)
		newmii.position = Vector2(95, 440)
	else: 
		newmii.texture_normal = preload("res://img/sprites/newmii.png")
		newmii.texture_pressed = preload("res://img/sprites/newmiibluebig.png")
		newmiitext.visible = true
		newmii.scale = Vector2(1, 1)
		newmii.position = Vector2(30, 428)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_down() -> void:
	$Click.play()


func _on_pressed() -> void:
	fade.play_backwards("fade out")
	$"Click(1)".play()
	await get_tree().create_timer(0.8).timeout
	get_tree().change_scene_to_file("res://scene/main mii maker.tscn")

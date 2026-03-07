extends Node3D
@onready var skeleton = $body/Skeleton3D
@export var head_id = 1
@export var hair_id = 1
@export var rotation_speed = 10
var target_rotation: float = 0.0
var current_head
var current_hair
var attachment = BoneAttachment3D.new()

var head_paths = {
	1: "res://models/heads/head1.glb",
	2: "res://models/heads/head2.glb",
	3: "res://models/heads/head3.glb",
	4: "res://models/heads/head4.glb",
	5: "res://models/heads/head5.glb",
	6: "res://models/heads/head6.glb",
	7: "res://models/heads/head7.glb",
	8: "res://models/heads/head8.glb"
}

var hair_paths = {
	1: "res://models/hair/hair1.glb",
	71: "res://models/hair/hair71.glb"
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attachment.bone_name = "neck"
	skeleton.add_child(attachment)
	
	load_head()
	load_hair()
	
	if head_id == 3:
		current_hair.position.x += 0.09
	else:
		current_hair.position.x = 0.0
	
	if head_id == 7:
		current_hair.position.x += 0.09
	else:
		current_hair.position.x = 0.0
		
	if head_id == 8:
		current_hair.position.x += 0.09
	else:
		current_hair.position.x = 0.0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$AnimationPlayer.play("Ewait00")
	
	
func load_head():

	if current_head:
		current_head.queue_free()

	var head_scene = load(head_paths[head_id])
	current_head = head_scene.instantiate()
	
	attachment.add_child(current_head)
	
func load_hair():

	if current_hair:
		current_hair.queue_free()

	var hair_scene = load(hair_paths[hair_id])
	current_hair = hair_scene.instantiate()
	
	attachment.add_child(current_hair)


func set_head(id):
	head_id = id
	load_head()

func set_hair(id):
	hair_id = id
	load_hair()

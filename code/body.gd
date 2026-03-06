extends Node3D
@onready var skeleton = $body/Skeleton3D
@export var head_id = 1
@export var hair_id = 1
@export var rotation_speed = 10
var target_rotation: float = 0.0

var head_paths = {
	1: "res://models/heads/head1.glb",
	2: "res://models/heads/head2.glb"
}

var hair_paths = {
	1: "res://models/hair/hair1.glb",
	71: "res://models/hair/hair71.glb"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var attachment = BoneAttachment3D.new()
	attachment.bone_name = "neck"
	skeleton.add_child(attachment)
	
	var head_scene = load(head_paths[head_id])
	var head = head_scene.instantiate()
	var hair_scene = load(hair_paths[hair_id])
	var hair = hair_scene.instantiate()
	attachment.add_child(head)
	attachment.add_child(hair)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$AnimationPlayer.play("Ewait00")
	

extends Node3D
@onready var skeleton = $body/Skeleton3D
@export var head_id = 1
@export var hair_id = 1
@export var hairflip = false
@export var skin_id = 1
@export var rotation_speed = 3
var target_rotation: float = 0.0
var current_head
var current_skin
var current_hair
var attachment = BoneAttachment3D.new()
var rotating = false
var start_rotation = 0.0

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
	2: "res://models/hair/hair2.glb",
	3: "res://models/hair/hair3.glb",
	22:"res://models/hair/hair22.glb",
	71: "res://models/hair/hair71.glb"
}

var skin_tones = {
	1: Color("fcdbbaff"),
	2: Color("f7bb7bff")
}

var face_material: ShaderMaterial
var hair_material: ShaderMaterial

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attachment.bone_name = "neck"
	skeleton.add_child(attachment)
	
	face_material = ShaderMaterial.new()
	face_material.shader = load("res://other/basic.gdshader")
	face_material.set_shader_parameter("use_texture", false)
	face_material.set_shader_parameter("albedo", Color(0.988, 0.859, 0.729, 1.0))
	hair_material = ShaderMaterial.new()
	hair_material.shader = load("res://other/basic.gdshader")
	hair_material.set_shader_parameter("use_texture", false)
	#hair_material.set_shader_parameter("albedo", Color(0.25,0.12,0.06))
	hair_material.set_shader_parameter("albedo", Color("401f0fff"))
	
	load_head()
	load_hair()
	set_skin(skin_id)
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$AnimationPlayer.play("Ewait00")
	
	if Input.is_action_just_pressed("mii spin") and !rotating:
		$"../StartRotate".play()
		rotating = true
		start_rotation = rotation.y
		target_rotation = start_rotation + TAU
		
	if rotating:
		rotation.y += rotation_speed * _delta
		
	if rotation.y >= target_rotation:
		rotation.y = target_rotation
		rotating = false
		
func apply_shader(node: Node, material_type: int, mesh_count: int = 0, should_fix_mesh: bool = false) -> int:
	for child in node.get_children():
		if child is MeshInstance3D:
			if should_fix_mesh:
				fix_mesh(child)
			
			for i in child.get_surface_override_material_count():
				var effective_type = material_type
				if material_type == 1:
					effective_type = 1 if mesh_count == 0 else 0
				match effective_type:
					0:
						child.set_surface_override_material(i, face_material)
					_:
						child.set_surface_override_material(i, hair_material)
			mesh_count += 1
		mesh_count = apply_shader(child, material_type, mesh_count, should_fix_mesh)
	return mesh_count
	
func fix_mesh(mesh_instance: MeshInstance3D, weld_threshold: float = 0.001) -> void:
	var new_mesh = ArrayMesh.new()
	
	for s in mesh_instance.mesh.get_surface_count():
		var st = SurfaceTool.new()
		st.create_from(mesh_instance.mesh, s)
		var arr = st.commit_to_arrays()
		
		var old_verts: PackedVector3Array = arr[Mesh.ARRAY_VERTEX]
		var old_uvs: PackedVector2Array = arr[Mesh.ARRAY_TEX_UV]
		var old_indices = arr[Mesh.ARRAY_INDEX]

		var unique_verts: PackedVector3Array = []
		var unique_uvs: PackedVector2Array = []
		var remap: PackedInt32Array = []
		remap.resize(old_verts.size())
		
		for i in old_verts.size():
			var found = -1
			for j in unique_verts.size():
				if old_verts[i].distance_to(unique_verts[j]) < weld_threshold:
					found = j
					break
			if found == -1:
				remap[i] = unique_verts.size()
				unique_verts.append(old_verts[i])
				unique_uvs.append(old_uvs[i] if old_uvs.size() > 0 else Vector2.ZERO)
			else:
				remap[i] = found
	
		var new_indices: PackedInt32Array = []
		if old_indices.size() > 0:
			for idx in old_indices:
				new_indices.append(remap[idx])
		else:
			for i in old_verts.size():
				new_indices.append(remap[i])
		
		var smooth_normals: PackedVector3Array = []
		smooth_normals.resize(unique_verts.size())
		for i in smooth_normals.size():
			smooth_normals[i] = Vector3.ZERO
		
		for i in range(0, new_indices.size(), 3):
			var ia = new_indices[i]
			var ib = new_indices[i + 1]
			var ic = new_indices[i + 2]
			var edge1 = unique_verts[ib] - unique_verts[ia]
			var edge2 = unique_verts[ic] - unique_verts[ia]
			var face_normal = edge1.cross(edge2).normalized()
			smooth_normals[ia] += face_normal
			smooth_normals[ib] += face_normal
			smooth_normals[ic] += face_normal
		
		for i in smooth_normals.size():
			smooth_normals[i] = -smooth_normals[i].normalized()
		
		var final_arr = []
		final_arr.resize(Mesh.ARRAY_MAX)
		final_arr[Mesh.ARRAY_VERTEX] = unique_verts
		final_arr[Mesh.ARRAY_NORMAL] = smooth_normals
		final_arr[Mesh.ARRAY_TEX_UV] = unique_uvs
		final_arr[Mesh.ARRAY_INDEX] = new_indices
		
		new_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, final_arr)
	
	mesh_instance.mesh = new_mesh
		
		

func load_head():

	if current_head:
		current_head.queue_free()

	var head_scene = load(head_paths[head_id])
	current_head = head_scene.instantiate()
	
	attachment.add_child(current_head)
	apply_shader(current_head, 0, 0, true)
	
	
func load_hair():

	if current_hair:
		current_hair.queue_free()

	var hair_scene = load(hair_paths[hair_id])
	current_hair = hair_scene.instantiate()
	
	attachment.add_child(current_hair)
	apply_shader(current_hair, 1, 0, true)
	
	if hairflip == true:
		current_hair.scale.y = -1
	else:
		current_hair.scale.y = 1
		
func set_skin(id):
	skin_id = id
	if skin_tones.has(skin_id):
		face_material.set_shader_parameter("albedo", skin_tones[skin_id])


func set_head(id):
	head_id = id
	load_head()
	
	
func set_hair(id):
	hair_id = id
	load_hair()

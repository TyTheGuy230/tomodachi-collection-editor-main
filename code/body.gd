extends Node3D
@onready var skeleton = $body/Skeleton3D
@onready var rotation_speed = 3
@export var head_id = 1
@export var skin_id = 1
@export var hair_id = 1
@export var hat_id = 1
@export var hairflip = false
@export var eyeb_id = 1
@export var eyeb_pos := Vector3(0,0,0)
@export var eye_id = 1
@export var eye_pos := Vector3(0,0,0)
@export var gender_id = 1
var target_rotation: float = 0.0
var current_gender
var current_head
var current_skin
var current_hair
var current_hat
var current_eyeb
var current_eye
var attachment = BoneAttachment3D.new()
var rotating = false
var start_rotation = 0.0
@onready var ani = $AnimationPlayer

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

var head_pos = {
	1: Vector3(0, 0, 0),
	2: Vector3(0, 0, 0),
	3: Vector3(0.080, 0, 0),
	4: Vector3(0, 0, 0),
	5: Vector3(0, 0, 0),
	6: Vector3(0, 0, 0),
	7: Vector3(0.06, 0, 0),
	8: Vector3(0.079, 0, 0)
}

var head_base_eyeb_pos = {
	1: Vector3(0.69, -0.06, 0),
	2: Vector3(0.69, -0.06, 0),
	3: Vector3(0.76, -0.06, 0),
	4: Vector3(0.69, -0.06, 0),
	5: Vector3(0.69, -0.06, 0),
	6: Vector3(0.69, -0.06, 0),
	7: Vector3(0.76, -0.06, 0),
	8: Vector3(0.76, -0.06, 0)
}

var head_base_eye_pos = {
	1: Vector3(0.60, -0.06, 0),
	2: Vector3(0.60, -0.06, 0),
	3: Vector3(0.67, -0.06, 0),
	4: Vector3(0.60, -0.06, 0),
	5: Vector3(0.60, -0.06, 0),
	6: Vector3(0.60, -0.06, 0),
	7: Vector3(0.67, -0.06, 0),
	8: Vector3(0.67, -0.06, 0)
}

var eyeb_offset = Vector3(0, 0, 0)
var eye_offset = Vector3(0, 0, 0)

var hair_paths = {
	1: "res://models/hair/hair1.glb",
	2: "res://models/hair/hair2.glb",
	3: "res://models/hair/hair3.glb",
	4: "res://models/hair/hair4.glb",
	5: "res://models/hair/hair5.glb",
	6: "res://models/hair/hair6.glb",
	7: "res://models/hair/hair7.glb",
	8: "res://models/hair/hair8.glb",
	9: "res://models/hair/hair9.glb",
	10: "res://models/hair/hair10.glb",
	11: "res://models/hair/hair11.glb",
	12: "res://models/hair/hair12.glb",
	13: "res://models/hair/hair13.glb",
	14: "res://models/hair/hair14.glb",
	15: "res://models/hair/hair15.glb",
	16: "res://models/hair/hair16.glb",
	17: "res://models/hair/hair17.glb",
	18: "res://models/hair/hair18.glb",
	19: "res://models/hair/hair19.glb",
	20: "res://models/hair/hair20.glb",
	21: "res://models/hair/hair21.glb",
	22: "res://models/hair/hair22.glb",
	23: "res://models/hair/hair23.glb",
	24: "res://models/hair/hair24.glb",
	25: "res://models/hair/hair25.glb",
	26: "res://models/hair/hair26.glb",
	27: "res://models/hair/hair27.glb",
	28: "res://models/hair/hair28.glb",
	29: "res://models/hair/hair29.glb",
	30: "res://models/hair/hair30.glb",
	31: "res://models/hair/hair31.glb",
	32: "res://models/hair/hair32.glb",
	33: "res://models/hair/hair33.glb",
	35: "res://models/hair/hair35.glb",
	34: "res://models/hair/hair34.glb",
	36: "res://models/hair/hair36.glb",
	37: "res://models/hair/hair37.glb",
	45: "res://models/hair/hair45.glb",
	65: "res://models/hair/hair65.glb",
	71: "res://models/hair/hair71.glb",
}



var hat_paths = {
	1: "res://models/hats/hat1.glb",
	2: "res://models/hats/hat2.glb"
}

var gender_paths = {
	1: "res://scene/body.tscn",
	2: "res://scene/body2.tscn"
}

var eyeb_paths = {
	1: "res://models/eyebrow/eyebrow1.glb",
}

var eye_paths = {
	1: "res://models/eyes/eye1.glb",
}

var skin_tones = {
	1: Color("fcdbbaff"),
	2: Color("f7bb7bff"),
	3: Color("df8e55ff"),
	4: Color("ffb696ff"),
	5: Color("9e5534ff"),
	6: Color("5d2c1cff"),
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
	load_hat()
	load_eyeb()
	load_eye()
	

	
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

	var pos = head_pos.get(head_id, Vector3.ZERO)
	current_head.position = pos
	
	
	
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

func _input(event):	
	
	moveparts(event)
	
	if event.is_action_pressed("switchhairs"):
		hair_id += 1
		current_hair.queue_free()
		var hair_scene = load(hair_paths[hair_id])
		current_hair = hair_scene.instantiate()
		attachment.add_child(current_hair)
		apply_shader(current_hair, 1, 0, true)
		
func load_hat():

	if current_hat:
		current_hat.queue_free()
		

	var hat_scene = load(hat_paths[hat_id])
	current_hat = hat_scene.instantiate()
	
	attachment.add_child(current_hat)
	
	if hair_id == 35:
		current_hat.visible = true
		hat_id = 2
	elif hair_id == 36:
		current_hat.visible = true
		hat_id = 1
	else:
		current_hat.visible = false
		
func load_eyeb():

	if current_eyeb:
		current_eyeb.queue_free()

	var eyeb_scene = load(eyeb_paths[eyeb_id])
	current_eyeb = eyeb_scene.instantiate()
	
	attachment.add_child(current_eyeb)
	
	var base_pos = head_base_eyeb_pos.get(head_id, Vector3.ZERO)
	eyeb_pos = base_pos + eyeb_offset
	current_eyeb.position = eyeb_pos
	
func load_eye():

	if current_eye:
		current_eye.queue_free()

	var eye_scene = load(eye_paths[eye_id])
	current_eye = eye_scene.instantiate()
	
	attachment.add_child(current_eye)
	
	var base_pos = head_base_eye_pos.get(head_id, Vector3.ZERO)
	eye_pos = base_pos + eye_offset
	current_eye.position = eye_pos
	
	
func moveparts(event): #dont remove
	if not current_eyeb:
		return
		
	if not current_eye:
		return
		
	var base_pos_eyeb = head_base_eyeb_pos.get(head_id, Vector3.ZERO)
	current_eyeb.position = base_pos_eyeb + eyeb_offset
	
	var base_pos_eye = head_base_eye_pos.get(head_id, Vector3.ZERO)
	current_eye.position = base_pos_eye + eye_offset
	

	
	
func load_gender():

	if current_gender:
		current_gender.queue_free()

	var gender_scene = load(gender_paths[gender_id])
	current_gender = gender_scene.instantiate()
	
	attachment.add_child(current_gender)
	apply_shader(current_gender, 1, 0, true)
	
func set_skin(id):
	skin_id = id
	if skin_tones.has(skin_id):
		face_material.set_shader_parameter("albedo", skin_tones[skin_id])


func set_head(id):
	var old_offset = eyeb_offset
	
	head_id = id
	load_head()
	load_eyeb()
	load_eye()
	
	var base_pos_eyeb = head_base_eyeb_pos.get(head_id, Vector3.ZERO)
	eyeb_offset = old_offset
	load_eyeb()
	current_eyeb.position = base_pos_eyeb + eyeb_offset
	
	var base_pos_eye = head_base_eye_pos.get(head_id, Vector3.ZERO)
	eye_offset = old_offset
	load_eye()
	current_eye.position = base_pos_eye + eye_offset
	
	
func set_hair(id):
	hair_id = id
	load_hair()
	load_hat()
	
func set_eyeb(id):
	eyeb_id = id
	load_eyeb()
	
func set_eye(id):
	eye_id = id
	load_eye()

extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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

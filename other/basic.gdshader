shader_type spatial;
render_mode unshaded, cull_front;

// lighting
uniform vec3 light_direction = vec3(0.51, -0.46, -0.56);
uniform float ambient : hint_range(0.0, 1.0) = 0.0;
varying float vertex_light;
// color
uniform bool use_texture = false;
uniform vec4 albedo : source_color = vec4(1.0, 0.0, 1.0, 1.0);
uniform sampler2D input_tex : filter_nearest;

void vertex() {
	// Mirror wrapping
	UV = fract(UV / 2.0);
	UV = min(UV, 1.0 - UV) * 2.0;

	// vertex lighting
	vec3 world_normal = normalize((MODEL_MATRIX * vec4(NORMAL, 0.0)).xyz);
	vec3 light_dir = normalize(-light_direction);
	float diff = max(dot(world_normal, light_dir), 0.0);
	vertex_light = 1.0 - clamp(ambient + diff * (1.0 - ambient), 0.0, 1.0);
}

void fragment() {
	vec4 base;
	if (use_texture) {
		base = texture(input_tex, UV);
	} else {
		base = albedo;
		base.a = 1.0;
	}

	ALBEDO = base.rgb * vertex_light;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}

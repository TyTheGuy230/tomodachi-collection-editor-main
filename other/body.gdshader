shader_type spatial;

uniform vec3 light_direction = vec3(0.245, -0.08, -0.4);
uniform float light_intensity : hint_range(0.0, 2.0) = 1.0;
uniform float ambient : hint_range(0.0, 1.0) = 0.3;
varying float vertex_light;

void vertex() {
	// Mirror wrapping
	UV = fract(UV / 2.0);
	UV = min(UV, 1.0 - UV) * 2.0;

	vec3 world_normal = normalize((MODEL_MATRIX * vec4(NORMAL, 0.0)).xyz);
	vec3 light_dir = normalize(-light_direction);
	float diff = max(dot(world_normal, light_dir), 0.0);
	vertex_light = clamp(ambient + diff * (1.0 - ambient), 0.0, 1.0);
}

uniform sampler2D input_tex: filter_nearest;
uniform vec3 favorite_color: source_color;
uniform vec3 skin_color: source_color;

void fragment() {
	vec4 tex = texture(input_tex, UV);
	vec3 col = vec3(tex.rgb);
	
	// color replace
	vec3 shirt = vec3(0.0, 1.0, 1.0);
	vec3 skin = vec3(1.0, 1.0, 0.0);
	float eps = 0.1;
	float is_shirt = 1.0 - step(eps, distance(col.rgb, shirt));
	float is_skin = 1.0 - step(eps, distance(col.rgb, skin));
	col.rgb = mix(col.rgb, favorite_color, is_shirt);
	col.rgb = mix(col.rgb, skin_color, is_skin);
	
	ALBEDO = col * vertex_light;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}

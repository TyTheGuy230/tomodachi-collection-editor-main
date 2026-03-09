shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform sampler2D input_tex: filter_nearest;
uniform vec3 favorite_color;
uniform vec3 favorite_color2;

void fragment() {
	// mirror wrapping
	vec2 uv = UV;
	uv = fract(uv / 2.0);
	uv = min(uv, 1.0 - uv) * 2.0;
	vec4 tex = texture(input_tex, uv);
	vec3 col = vec3(tex.rgb);
	
	// color replace
	vec3 shirt = vec3(0.0, 1.0, 1.0);
	vec3 fav2 = vec3(1.0, 1.0, 0.0);
	float eps = 0.1;
	float is_shirt = 1.0 - step(eps, distance(col.rgb, shirt));
	float is_fav2 = 1.0 - step(eps, distance(col.rgb, fav2));
	col.rgb = mix(col.rgb, favorite_color, is_shirt);
	col.rgb = mix(col.rgb, favorite_color2, is_fav2);
	
	ALBEDO = col;
	
	}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//
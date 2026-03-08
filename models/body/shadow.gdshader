shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform sampler2D input_tex;
void fragment() {
	// mirror wrapping + alpha
	vec2 uv = UV;
	uv = fract(uv / 2.0);
	uv = min(uv, 1.0 - uv) * 2.0;
	vec4 tex = texture(input_tex, uv);
	ALBEDO = vec3(tex.rgb);
	ALPHA = tex.a;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}

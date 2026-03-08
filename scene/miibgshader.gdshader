shader_type spatial;

uniform sampler2D input_tex: filter_nearest;
void vertex() {
    UV.x += TIME * .04;
}
void fragment() {
    vec4 tex = texture(input_tex, UV);
    ALBEDO = vec3(tex.xyz);
	ALPHA = 1.7;
}
shader_type spatial;

uniform sampler2D face_texture;
uniform sampler2D shadow_texture; // new texture slot

void fragment() {
    vec4 face = texture(face_texture, UV);
    vec4 shadow = texture(shadow_texture, UV);

    ALBEDO = face.rgb * shadow.rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}

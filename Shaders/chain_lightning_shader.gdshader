shader_type canvas_item;
uniform float tiling_amount : hint_range(1.0, 5.0) = 1.0;

void fragment() {
	vec4 new_tex = texture(TEXTURE, UV);
	vec2 new_uv = UV;
	new_uv.x = new_uv.x*tiling_amount;
	//new_uv.y += sin(TIME * 20.0 + new_uv.x * 10.0) * 0.02;
	new_tex = texture(TEXTURE, new_uv);
	COLOR = new_tex;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

shader_type canvas_item;
uniform float tiling_amount = 1.0;

void fragment() {
	vec4 new_tex = texture(TEXTURE, UV);
	vec2 new_uv = UV;
	new_uv.x = new_uv.x*tiling_amount;
	//new_uv.y += (sin(new_uv.x*2.0*PI))*(0.2);
	new_uv.y += 0.2*acos(abs(sin(new_uv.x*PI)))-PI/20.0;
	new_tex = texture(TEXTURE, new_uv);
	COLOR = new_tex;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

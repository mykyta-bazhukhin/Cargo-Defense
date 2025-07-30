shader_type canvas_item;

uniform vec4 flash_color = vec4(0.8,0.8,0.8,1.0);
uniform bool flash_on = false;
uniform float flash_mix = 0;

void fragment() {
	vec4 sprite = texture(TEXTURE, UV);
	vec3 final_rgb;
	if (flash_on == true)
	{
		sprite.a = mix(sprite.a, sprite.a-0.1, flash_mix);
		final_rgb = mix(flash_color.rgb, vec3(0.62,0.62,0.62), flash_mix);
		COLOR = vec4(final_rgb, sprite.a);
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

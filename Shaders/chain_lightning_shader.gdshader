shader_type canvas_item;
uniform float tiling_amount = 1.0;
uniform float seed;

void fragment() {
	vec2 new_uv = UV;
    new_uv.x *= tiling_amount;

    float band = floor(new_uv.x);
    float next_band = band + 1.0;

    float rand1 = fract(sin(dot(vec2(band, seed), vec2(12.9898, 78.233))) * 43758.5453);
    float rand2 = fract(sin(dot(vec2(next_band, seed), vec2(12.9898, 78.233))) * 43758.5453);

    float amp1 = mix(0.05, 0.4, rand1);
    float amp2 = mix(0.05, 0.4, rand2);

    float frac = fract(new_uv.x);

    float amp = mix(amp1, amp2, frac);

    new_uv.y += amp * acos(abs(sin(new_uv.x * PI))) - PI / 20.0;

    vec4 new_tex = texture(TEXTURE, new_uv);
    COLOR = new_tex;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

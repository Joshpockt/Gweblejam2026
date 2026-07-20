shader_type canvas_item;

uniform bool can_interact = false;
uniform sampler2D screen_texture : hint_screen_texture;

void fragment() {
	COLOR.rgb = texture(screen_texture,UV).rgb * -1.0 + 1.0;
	COLOR.a = 0.0;
	if (!can_interact) {
		COLOR.a = smoothstep(0.2, 0.175, distance(vec2(0.5), UV));
	} 
	else {
		COLOR.a = smoothstep(0.5, 0.475, distance(vec2(0.5), UV));
		COLOR.a -= smoothstep(0.325, 0.3, distance(vec2(0.5), UV));
	}
}

shader_type canvas_item;

uniform vec2 direction = vec2(1.0, 0.0);
uniform float speed_scale : hint_range(-0.5, 0.5, 0.05) = 0.1;

void fragment() {
	vec2 move = direction * TIME * speed_scale;
	COLOR = texture(TEXTURE, UV + move);
}

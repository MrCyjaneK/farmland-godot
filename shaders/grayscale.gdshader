shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
	float mean = (color.r + color.g + color.b) / 3.0;
	COLOR.rgb = vec3(mean);
}

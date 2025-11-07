shader_type canvas_item;
uniform int color_count: hint_range(1,8) = 2;
uniform vec4 target_color[2]: source_color;
uniform vec4 replace_color[2]: source_color;
uniform float tolerance: hint_range(0.0, 1.0);
void fragment() {
	vec4 text_color = texture(TEXTURE,UV);
	for ( int i = 0 ; i < color_count ; i++){
		float dist = distance(text_color.rgb, target_color[i].rgb);
		if (dist < tolerance){
			text_color.rgb = replace_color[i].rgb;
		}
		
		COLOR = text_color;
	}
}


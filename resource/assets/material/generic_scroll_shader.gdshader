// Ensure that the texture has the repeat property enabled

shader_type canvas_item;

uniform vec2 dir = vec2(0.0,-1.0);
uniform float scroll_weight = 1.0;

uniform bool ocillate = false;

void fragment() {
	vec2 dt_step;
	
	if (ocillate) {
		dt_step = vec2(dir.x * (cos(TIME)) * scroll_weight, dir.y * (sin(TIME)) * scroll_weight);
	}
	else {
		dt_step = vec2(dir.x * ((TIME)) * scroll_weight, dir.y * ((TIME)) * scroll_weight);
	}
	COLOR = texture(TEXTURE, UV + dt_step);
}

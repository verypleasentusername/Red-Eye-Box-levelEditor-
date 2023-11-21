shader_type canvas_item;
render_mode unshaded;

uniform sampler2D cam_vw;

void fragment() {
	COLOR = texture(cam_vw, UV);
}
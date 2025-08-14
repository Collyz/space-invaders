shader_type canvas_item;

uniform float time = 1.0;


// Example uniform for animation speed
void fragment() {
	// Get the original color of the text pixel
	vec4 original_color = texture(TEXTURE, UV);
	// Example: Create a simple color gradient based on UV.x and time
	float gradient_factor = sin(UV.x * 5.0 + TIME * time) * 0.5 + 0.5;
	vec4 new_color = mix(vec4(1.0, 0.0, 0.0, 1.0), vec4(0.0, 0.0, 1.0, 1.0), gradient_factor);
	// Apply the new color, preserving original alpha for transparency
	COLOR = vec4(new_color.rgb, original_color.a);
}
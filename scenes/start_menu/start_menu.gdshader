shader_type canvas_item;

uniform float time_speed = 0.1;

// Helper: convert HSV to RGB
vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0/3.0, 1.0/3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void fragment() {
    vec4 original_color = texture(TEXTURE, UV);

    // Hue cycles over time (0.0 → 1.0 wraps around rainbow)
    float hue = mod(TIME * time_speed - UV.x - UV.y, 1.0);

    // Convert HSV to RGB: full saturation & brightness
    vec3 rainbow = hsv2rgb(vec3(hue, 1.0, 1.0));

    // Apply rainbow, keep original alpha
    COLOR = vec4(rainbow, original_color.a);
}

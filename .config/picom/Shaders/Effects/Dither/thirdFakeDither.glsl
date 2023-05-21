// picom shader to imitate ordered dithering while preserving hue.
// colorspace conversions taken from https://github.com/tobspr/GLSL-Color-Spaces.
//
// author: PickNicko13
// license: GPLv3

#version 330
#ifdef GL_ES
	precision highp float;
#endif
#define saturate(v) clamp(v, 0, 1)

// Constants
const float EPSILON = 1e-7;

const int colors = 5;

const int[64] dither_table = int[](
	0, 48, 12, 60, 3, 51, 15, 63,
	32, 16, 44, 28, 35, 19, 47, 31,
	8,  56, 4,  52, 11, 59, 7,  55,
	40, 24, 36, 20, 43, 27, 39, 23,
	2,  50, 14, 62, 1,  49, 13, 61,
	34, 18, 46, 30, 33, 17, 45, 29,
	10, 58, 6,  54, 9,  57, 5,  53,
	42, 26, 38, 22, 41, 25, 37, 21
);

// Uniforms
in vec2 texcoord;
uniform float opacity;
uniform bool invert_color;
uniform sampler2D tex;

// Converts a value from linear RGB to HCV (Hue, Chroma, Value)
vec3 rgb_to_hcv(vec3 rgb){
    // Based on work by Sam Hocevar and Emil Persson
    vec4 P = (rgb.g < rgb.b) ? vec4(rgb.bg, -1.0, 2.0/3.0) : vec4(rgb.gb, 0.0, -1.0/3.0);
    vec4 Q = (rgb.r < P.x) ? vec4(P.xyw, rgb.r) : vec4(rgb.r, P.yzx);
    float C = Q.x - min(Q.w, Q.y);
    float H = abs((Q.w - Q.y) / (6.0 * C + EPSILON) + Q.z);
    return vec3(H, C, Q.x);
}
// Converts from pure Hue to linear RGB
vec3 hue_to_rgb(float hue){
    float R = abs(hue * 6.0 - 3.0) - 1.0;
    float G = 2.0 - abs(hue * 6.0 - 2.0);
    float B = 2.0 - abs(hue * 6.0 - 4.0);
    return saturate(vec3(R,G,B));
}
// Converts from HSV to linear RGB
vec3 hsv_to_rgb(vec3 hsv){
    vec3 rgb = hue_to_rgb(hsv.x);
    return ((rgb - 1.0) * hsv.y + 1.0) * hsv.z;
}
// Converts from linear RGB to HSV
vec3 rgb_to_hsv(vec3 rgb){
    vec3 HCV = rgb_to_hcv(rgb);
    float S = HCV.y / (HCV.z + EPSILON);
    return vec3(HCV.x, S, HCV.z);
}

vec2 dither(vec2 coord, vec2 color){
	// get matrix position
	int x = int(mod(coord.x, 24.0)/3.0);
	int y = int(mod(coord.y, 24.0)/3.0);
	int index = x + 8*y;
	float limit = (float(dither_table[index]) + 1.0) / 64.;
	
	vec2 diff;
	// clamp down color and save diff 0-1 value
	diff.x = modf(color.x*colors, color.x);
	diff.y = modf(color.y*colors, color.y);
	if (diff.x > limit)
		color.x += 1.0;
	if (diff.y > limit)
		color.y += 1.0;
	return color/colors;
}

vec4 window_shader(){
	vec4 color = texelFetch(tex, ivec2(texcoord), 0)*opacity;

	color.xyz = rgb_to_hsv(color.rgb);
	if (invert_color)
		color.z = 1.0 - color.z;
	color.yz = dither(texcoord, color.gb);

	return vec4(hsv_to_rgb(color.rgb), color.a);
}

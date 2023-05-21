// picom shader to apply ordered dithering to windows.
// the interesting thing is that even though the grid resolution is effectively halved,
// each pixel still gets color separately, thus not decreasing the real resolution
//
// author: PickNicko13
// license: GPLv3

#version 330
#ifdef GL_ES
	precision highp float;
#endif
#define saturate(v) clamp(v, 0, 1)

// Constants
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

vec3 dither(vec2 coord, vec3 color){
	// get matrix position
	int x = int(mod(coord.x, 24.0)/3);
	int y = int(mod(coord.y, 24.0)/3);
	int index = x + 8*y;
	float limit = (float(dither_table[index]) + 1.0) / 64.;
	
	vec3 diff;
	// clamp down color and save diff 0-1 value
	diff.x = modf(color.x*colors, color.x);
	diff.y = modf(color.y*colors, color.y);
	diff.z = modf(color.z*colors, color.z);
	if (diff.x > limit)
		color.x += 1.0;
	if (diff.y > limit)
		color.y += 1.0;
	if (diff.z > limit)
		color.z += 1.0;
	return color/colors;
}

vec4 window_shader(){
	vec4 color = texelFetch(tex, ivec2(texcoord), 0)*opacity;

	if (invert_color)
		color.rgb = 1.0 - color.rgb;
	color.rgb = dither(texcoord, color.rgb);

	return color;
}

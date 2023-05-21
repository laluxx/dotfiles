// picom shader to apply ordered dithering to opacity of windows.
// looks awful with light wallpapers because of low contrast with text,
// looks awful with non-bitmap fonts because they get transparency from background,
// looks awful with bitmap fonts because they get bordered awfully...
// looks awful.
//
// author: PickNicko13
// license: GPLv3

#version 330
#ifdef GL_ES
	precision highp float;
#endif
#define saturate(v) clamp(v, 0, 1)

// Constants
const int colors = 2;

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

float dither(vec2 coord, float color){
	// get matrix position
	int x = int(mod(coord.x, 8.0));
	int y = int(mod(coord.y, 8.0));
	int index = x + 8*y;
	// 1/colors effectively adds it to transparency
	float limit = float(dither_table[index]) / 64.;
	
	float diff;
	// clamp down color and save diff 0-1 value
	diff = modf(color*colors, color);
	if (diff > limit)
		color += 1.0;
	return color/colors;
}

vec4 window_shader(){
	vec4 color = texelFetch(tex, ivec2(texcoord), 0)*opacity;

	if (invert_color)
		color.rgb = 1.0 - color.rgb;
	color.a = dither(texcoord, color.a);

	return color;
}

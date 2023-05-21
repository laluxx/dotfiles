// picom shader to apply ordered dithering (4x4) to the opacity layer,
// effectively using a mask instead of fading.
//
// works best with:
// fade-{in,out}-step = 0.0625
// fade-delta = [1-3]/refreshrate
//
// author: PickNicko13
// license: GPLv3

#version 330
#ifdef GL_ES
	precision highp float;
#endif
#define saturate(v) clamp(v, 0, 1)

// Constants
const int colors = 1;

const int[16] dither_table = int[](
	0,8,2,10,
	12,4,14,6,
	3,11,1,9,
	15,7,13,5
);

// Uniforms
in vec2 texcoord;
uniform float opacity;
uniform bool invert_color;
uniform sampler2D tex;

float dither(vec2 coord, float color){
	// get matrix position
	int x = int(mod(coord.x, 4.0));
	int y = int(mod(coord.y, 4.0));
	int index = x + 4*y;
	float limit = (float(dither_table[index]) + 1.0) / 16.;
	
	float diff;
	// clamp down color and save diff 0-1 value
	diff = modf(color*colors, color);
	if (diff > limit)
		color += 1.0;
	return color/colors;
}

vec4 window_shader(){
	vec4 color = texelFetch(tex, ivec2(texcoord), 0);
	color.rgb *= opacity;
	color.a *= dither(texcoord, opacity);

	if (invert_color)
		color.rgb = 1.0 - color.rgb;

	return color;
}

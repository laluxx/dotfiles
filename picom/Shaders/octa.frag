#version 330

// translate from picom constants to common shadertoy stuff
in vec2 texcoord;             // texture coordinate of the fragment

uniform float time;
float iTime = (time/1000.0);

#define iChannel0 tex

uniform sampler2D tex;        // texture of the window

precision highp float;

vec2 iResolution = textureSize(tex, 0);

/*
insert copied shader toy here
*/

precision highp float;


float gTime = 0.;
const float REPEAT = 5.0;

// 回転行列
mat2 rot(float a) {
	float c = cos(a), s = sin(a);
	return mat2(c,s,-s,c);
}

float sdBox( vec3 p, vec3 b )
{
	vec3 q = abs(p) - b;
	return length(max(q,0.0)) + min(max(q.x,max(q.y,q.z)),0.0);
}

float box(vec3 pos, float scale) {
	pos *= scale;
	float base = sdBox(pos, vec3(.4,.4,.1)) /1.5;
	pos.xy *= 5.;
	pos.y -= 3.5;
	pos.xy *= rot(.75);
	float result = -base;
	return result;
}

float box_set(vec3 pos, float iTime) {
	vec3 pos_origin = pos;
	pos = pos_origin;
	pos .y += sin(gTime * 0.4) * 2.5;
	pos.xy *=   rot(.8);
	float box1 = box(pos,2. - abs(sin(gTime * 0.4)) * 1.5);
	pos = pos_origin;
	pos .y -=sin(gTime * 0.4) * 2.5;
	pos.xy *=   rot(.8);
	float box2 = box(pos,2. - abs(sin(gTime * 0.4)) * 1.5);
	pos = pos_origin;
	pos .x +=sin(gTime * 0.4) * 2.5;
	pos.xy *=   rot(.8);
	float box3 = box(pos,2. - abs(sin(gTime * 0.4)) * 1.5);	
	pos = pos_origin;
	pos .x -=sin(gTime * 0.4) * 2.5;
	pos.xy *=   rot(.8);
	float box4 = box(pos,2. - abs(sin(gTime * 0.4)) * 1.5);	
	pos = pos_origin;
	pos.xy *=   rot(.8);
	float box5 = box(pos,.5) * 6.;	
	pos = pos_origin;
	float box6 = box(pos,.5) * 6.;	
	float result = max(max(max(max(max(box1,box2),box3),box4),box5),box6);
	return result;
}

float map(vec3 pos, float iTime) {
	vec3 pos_origin = pos;
	float box_set1 = box_set(pos, iTime);

	return box_set1;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
	vec2 p = (fragCoord.xy * 2. - iResolution.xy) / min(iResolution.x, iResolution.y);
	vec3 ro = vec3(0., -0.2 ,iTime * 4.);
	vec3 ray = normalize(vec3(p, 1.5));
	ray.xy = ray.xy * rot(sin(iTime * .03) * 5.);
	ray.yz = ray.yz * rot(sin(iTime * .05) * .2);
	float t = 0.1;
	vec3 col = vec3(0.);
	float ac = 0.0;


	for (int i = 0; i < 99; i++){
		vec3 pos = ro + ray * t;
		pos = mod(pos-2., 4.) -2.;
		gTime = iTime -float(i) * 0.01;
		
		float d = map(pos, iTime);

		d = max(abs(d), 0.01);
		ac += exp(-d*23.);

		t += d* 0.55;
	}

	col = vec3(ac * 0.02);

	col +=vec3(0.,0.2 * abs(sin(iTime)),0.5 + sin(iTime) * 0.2);


	fragColor = vec4(col ,1.0 - t * (0.02 + 0.02 * sin (iTime)));
}

/*
end copied shader toy
*/

float lum(vec4 col) {
    const vec3 W = vec3(0.2125, 0.7154, 0.0721);
    return dot(col.rgb, W);
}

vec4 blur(sampler2D source, vec2 size, vec2 uv) {
    float Pi = 6.28318530718; // Pi*2
    
    // GAUSSIAN BLUR SETTINGS {{{
    float Directions = 16.0; // BLUR DIRECTIONS (Default 16.0 - More is better but slower)
    float Quality = 3.0; // BLUR QUALITY (Default 4.0 - More is better but slower)
    float Size = 8.0; // BLUR SIZE (Radius)
    // GAUSSIAN BLUR SETTINGS }}}
   
    vec2 Radius = Size/iResolution.xy;
    
    // Pixel colour
    vec4 Color = texture(iChannel0, uv);
    
    // Blur calculations
    for( float d=0.0; d<Pi; d+=Pi/Directions)
    {
		for(float i=1.0/Quality; i<=1.0; i+=1.0/Quality)
        {
			Color += texture( iChannel0, uv+vec2(cos(d),sin(d))*Radius*i);		
        }
    }
    
    // Output to screen
    Color /= Quality * Directions - 15.0;
    return Color;
}

// Default window post-processing:
// 1) invert color
// 2) opacity / transparency
// 3) max-brightness clamping
// 4) rounded corners
vec4 default_post_processing(vec4 c);

// Default window shader:
// 1) fetch the specified pixel
// 2) apply default post-processing
vec4 window_shader() {
    vec4 original = texelFetch(tex, ivec2(texcoord), 0);
    vec4 signal;
    mainImage(signal, texcoord);
    vec2 uv = texcoord.xy / iResolution.xy;
    vec4 mask = blur(tex, iResolution, uv);
    return default_post_processing(original + signal * mask);
    // return max(original, signal * mask);
    // return mix(original, signal, lum(mask));
    // return default_post_processing(max(signal, original));
}
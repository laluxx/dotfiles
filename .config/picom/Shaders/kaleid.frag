#version 330

// translate from picom constants to common shadertoy stuff
in vec2 texcoord;             // texture coordinate of the fragment

uniform float time;
#define iTime (time/1000.0)

#define iChannel0 tex

uniform sampler2D tex;        // texture of the window

precision highp float;

vec2 iResolution = textureSize(tex, 0);

/*
insert copied shader toy here
*/

#define NUM_LAYERS 10.

mat2 Rot(float a) {
  float c = cos(a), s = sin(a);
  return mat2(c, -s, s, c);
}

float Star(vec2 uv, float flare) {
    float col = 0.;
    float d = length(uv);
    float m = .02/d;
    
    float rays = max(0., 1. - abs(uv.x * uv.y * 1000.));
    m += rays * flare;
    uv *= Rot(3.1415/4.);
    rays = max(0., 1. - abs(uv.x * uv.y * 1000.));
    m += rays * .3 * flare;
    
    m *= smoothstep(1., .2, d);

    return m;
}

float Hash21(vec2 p) {
  p = fract(p * vec2(123.34, 456.21));
  p += dot(p, p+45.32);
  
  return fract(p.x*p.y);
}

vec3 StarLayer(vec2 uv) {
    vec3 col = vec3(0.);
    
    vec2 gv = fract(uv) - 0.5;
    vec2 id = floor(uv);
    
    for(int y = -1; y <= 1; y++ ) {
        for(int x = -1; x <= 1; x++) {
            vec2 offs = vec2(x, y);

            float n = Hash21(id + offs);
            float size = fract(n*345.32);
            
            vec2 p = vec2(n, fract(n*34.));
            
            float star = Star(gv - offs - p + .5, smoothstep(.8, 1., size) * .6);
            
            vec3 hueShift = fract(n*2345.2 + dot(uv /420.,texture(iChannel0, vec2(0.25, 0.)).rg))*vec3(.2, .3, .9)*123.2;

            vec3 color = sin(hueShift) * .5 + .5;
            color = color * vec3(1., .25, 1.+size);

            star *= sin(iTime*3.+n*6.2831)*.4+1.;
            col += star * size * color;
        }
    }
    
    return col;

}

vec2 N(float angle) {
  return vec2(sin(angle), cos(angle));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (fragCoord - 0.5*iResolution.xy)/iResolution.y;
    // vec2 M = (iMouse.xy - iResolution.xy*.5)/iResolution.y;
    float t = iTime * .01;
    
    uv.x = abs(uv.x);
    uv.y += tan((5./6.) * 3.1415) * .5;

    vec2 n = N((5./6.) * 3.1415);
    float d = dot(uv - vec2(.5, 0.), n);
    uv -= n * max(0., d) * 2.;

    // col += smoothstep(.01, .0, abs(d));

    n = N((2./3.) * 3.1415);
    float scale = 1.;
    uv.x += 1.5 / 1.25;
    for(int i=0; i<5; i++) {
        scale *= 1.25;
        uv *= 1.25;
        uv.x -= 1.5;

        uv.x = abs(uv.x);
        uv.x -= 0.5;
        uv -= n * min(0., dot(uv, n)) * 2.;
    }

 
    uv += 4.;

    uv *= Rot(t);
    vec3 col = vec3(0.);
    
    float layers = 10.;
    
    for(float i=0.; i < 1.; i+=1./NUM_LAYERS) {
        float depth = fract(i+t);
        float scale = mix(20., .5, depth);
        float fade = depth * smoothstep(1., .9, depth);
        col += StarLayer(uv * scale + i * 453.2) * fade;
    }

    fragColor = vec4(col,1.0);
}

/*
end copied shader toy
*/

// radius
const float r = 10.0;
float gaussianLum() {
    vec2 pos = texcoord;
    float xs = iResolution.x;
    float ys = iResolution.y;
    float x,y,xx,yy,rr=r*r,dx,dy,w,w0;
    w0=0.3780/pow(r,1.975);
    vec2 p;
    vec4 col=vec4(0.0,0.0,0.0,0.0);
    for (dx=1.0/xs,x=-r,p.x=0.5+(pos.x*0.5)+(x*dx);x<=r;x++,p.x+=dx) {
        xx=x*x;
        for (dy=1.0/ys,y=-r,p.y=0.5+(pos.y*0.5)+(y*dy);y<=r;y++,p.y+=dy) {
            yy=y*y;
            if (xx+yy<=rr) {
                w=w0*exp((-xx-yy)/(2.0*rr));
                col+=texture2D(tex,p)*w;
            }
        }
    }
    const vec3 W = vec3(0.2125, 0.7154, 0.0721);
    return dot(col.rgb, W);
}

//Pin Light
vec4 pinLight (vec4 target, vec4 blend){
    vec3 temp;
    temp.x = (blend.x > 0.5) ? (max (target.x, 2.0*(blend.x-0.5))) : (min(target.x, 2.0*blend.x));
    temp.y = (blend.y > 0.5) ? (max (target.y, 2.0*(blend.y-0.5))) : (min(target.y, 2.0*blend.y));
    temp.z = (blend.z > 0.5) ? (max (target.z, 2.0*(blend.z-0.5))) : (min(target.z, 2.0*blend.z));
    return vec4(temp, 1.);
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
    signal = mix(original, signal, gaussianLum());
    return max(original, signal);
    return default_post_processing(signal);
}
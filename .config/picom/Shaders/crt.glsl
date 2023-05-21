#version 430
#define PI 3.1415926538
uniform float opacity;
uniform float time;
uniform float sc_freq = 0.35;
uniform float sc_intensity = 0.5;
uniform bool grid = false;
uniform int distortion_offset = 2;
uniform int downscale_factor = 1;
uniform float sph_distance = 500;
uniform float curvature = 0.25;
uniform float shadow_cutoff = 1;
uniform int shadow_intensity = 1;
vec4 outside_color = vec4(0 ,0 ,0, opacity);
float flash_speed = 0;
float flash_intensity = 0.8;
in vec2 texcoord;
uniform sampler2D tex;
ivec2 window_size = textureSize(tex, 0);
ivec2 window_center = ivec2(window_size.x/2, window_size.y/2);
float radius = (window_size.x/curvature);
int flash = int(round(flash_speed*time/(10000/window_size.y))) % window_size.y;
vec4 default_post_processing(vec4 c);
vec4 darken_color(vec4 color, vec2 coords)
{
    if (shadow_intensity == 0)
    {return color;}
    vec2 distances_from_center = window_center - coords;
    float brightness = 1;
    brightness *= -pow((distances_from_center.y/window_center.y)*shadow_cutoff, 
                       (shadow_intensity)*4)+1;
    brightness *= -pow((distances_from_center.x/window_center.x)*shadow_cutoff, 
                       (shadow_intensity)*4)+1;
    color.xyz *= brightness * 2.5;
    return color;
}
ivec2 curve_coords_spheric(vec2 coords)
{
    coords -= window_center;
    vec2 curved_coords; 
    vec3 projection_coords3d = vec3(coords.x, coords.y, sqrt(pow(radius+sph_distance,2)-pow(coords.x,2)-pow(coords.y,2)));
    projection_coords3d *= ((radius+sph_distance)/projection_coords3d.z);
    curved_coords = projection_coords3d.xy;
    curved_coords += window_center;
    return ivec2(curved_coords);
}
vec4 get_pixel(vec2 coords)
{
    if (coords.x >=window_size.x-1 || coords.y >=window_size.y-1 || coords.x <=0 || coords.y <=0) {return outside_color;}
    vec4 color = texelFetch(tex, ivec2(coords), 0);
    return default_post_processing(color);
}
vec4 get_block_color(vec2 coords)
{
    if (downscale_factor < 2) {return get_pixel(coords);}
    ivec2 relative_position;
    relative_position.xy = ivec2(coords).xy % downscale_factor;
    vec4 average = vec4(0, 0 , 0, 0);
    for (int i = 0; i < downscale_factor; i++)
    {for (int j = 0; j < downscale_factor; j++){average.xyzw += get_pixel(vec2(coords.x + i - relative_position.x,coords.y + j - relative_position.y));}}
    average /= pow(downscale_factor, 2);
    return average;
}
vec4 window_shader() {
    vec2 curved_coords = curve_coords_spheric(texcoord);
    vec4 c = get_block_color(curved_coords);
    vec4 c_right = get_block_color(vec2(curved_coords.x+2, curved_coords.y));
    vec4 c_left = get_block_color(vec2(curved_coords.x-2, curved_coords.y));
    c = vec4(c_left.x, c.y, c_right.z, c.w);
    c.xyz *= sin(2*PI*sc_freq*(texcoord).y)/(2/sc_intensity) + 1 - sc_intensity/2;
    if (grid == true){c.xyz *= sin(2*PI*sc_freq*(texcoord).x)/(2/sc_intensity) + 1 - sc_intensity/2;}
    if (curved_coords.y >=flash-(window_size.y/10) && curved_coords.y <=flash){c.xyz *= flash_intensity*(pow(((flash-curved_coords.y)/(window_size.y/10))-1,2) + 1/flash_intensity);}
    c = darken_color(c, curved_coords);
    return (c);
}
//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~
//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform sampler2D palette_tex;
uniform float tex_left;
uniform float tex_top;
uniform float pixel_w;
uniform float size;
void main()
{
    vec3 color = (v_vColour * texture2D( gm_BaseTexture, v_vTexcoord )).rgb;
    
    vec3 picked_color;
    float min_dif;
    min_dif = 999.;
    for(float i = 0.0; i < size; i += 1.0) {
        vec3 n_color = texture2D( palette_tex, vec2(tex_left + pixel_w * i, tex_top) ).rgb;
        float dif;
        dif = sqrt((n_color.r - color.r)*(n_color.r - color.r) + (n_color.g - color.g)*(n_color.g - color.g) + (n_color.b - color.b)*(n_color.b - color.b));
        if(dif < min_dif) {
            min_dif = dif;
            picked_color = n_color;
        }
    }
    gl_FragColor = vec4(picked_color, texture2D( gm_BaseTexture, v_vTexcoord ).a);
}


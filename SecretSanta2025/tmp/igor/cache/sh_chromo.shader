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

uniform float shakex;
uniform float shakey;


void main()
{
    gl_FragColor = vec4(texture2D(gm_BaseTexture, vec2(v_vTexcoord.x - shakex*0.142, v_vTexcoord.y - shakey*0.0948)).r, texture2D(gm_BaseTexture, vec2(v_vTexcoord.x + shakex*0.0943, v_vTexcoord.y - shakey*0.05829)).g, texture2D(gm_BaseTexture, vec2(v_vTexcoord.x - shakex*0.042, v_vTexcoord.y + shakey*0.0624)).b, 1.0);
}


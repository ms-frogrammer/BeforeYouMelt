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

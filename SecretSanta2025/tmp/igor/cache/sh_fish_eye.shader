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

uniform float barrel_power;
void main()
{
	vec2 p = v_vTexcoord;
	
	// to custom (0 - center)
	p.x = 2. * p.x - 1.;
	p.y = 2. * p.y - 1.;

	
	float theta = atan(p.y, p.x);
	float radius = length(p);
	radius = pow(radius, barrel_power);
	p.x = radius * cos(theta);
	p.y = radius * sin(theta);
	
	// to uv (0.5 - center)
	p.x = 0.5 * (p.x + 1.);
	p.y = 0.5 * (p.y + 1.);
	
	
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, p );
}


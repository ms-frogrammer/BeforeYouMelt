//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float barrel_power;
uniform float chromox;
uniform float chromoy;
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
	gl_FragColor = vec4(texture2D(gm_BaseTexture, vec2(p.x - chromox*0.142, p.y - chromoy*0.0948)).r, texture2D(gm_BaseTexture, vec2(p.x + chromox*0.0943, p.y - chromoy*0.05829)).g, texture2D(gm_BaseTexture, vec2(p.x - chromox*0.042, p.y + chromoy*0.0624)).b, 1.0);
}

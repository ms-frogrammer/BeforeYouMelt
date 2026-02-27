varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D mask;
uniform sampler2D bg;

void main()
{
 
	float alpha = texture2D( mask, v_vTexcoord ).a;
  
  	vec4 baseColor = texture2D( gm_BaseTexture , v_vTexcoord );
	vec4 bgColor = texture2D( bg, v_vTexcoord );
	vec4 newColor = mix(bgColor, baseColor, alpha);
	
  
  
	gl_FragColor = newColor;
}

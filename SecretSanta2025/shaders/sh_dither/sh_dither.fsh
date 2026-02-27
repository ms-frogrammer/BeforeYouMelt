//If you want more details on this method of dithering read up on "Ordered dithering"
//Fragment shader variable initialization.
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;

// NOTE FROM RIUKU:
// Had to implement the functions vec4_get and mat4_get because
// on WebGL (HTML5 export) accessing a matrix or a vec by an index that
// isn't a compile-time constant value causes a shader compilation error.
float vec4_get(vec4 vec, int index, float default_value)
{
	if      (index == 0) return vec[0];
	else if (index == 1) return vec[1];
	else if (index == 2) return vec[2];
	else if (index == 3) return vec[3];
	return default_value;
}
float mat4_get(mat4 matrix, int index1, int index2, float default_value)
{
	if      (index1 == 0) return vec4_get(matrix[0], index2, default_value);
	else if (index1 == 1) return vec4_get(matrix[1], index2, default_value);
	else if (index1 == 2) return vec4_get(matrix[2], index2, default_value);
	else if (index1 == 3) return vec4_get(matrix[3], index2, default_value);
	return default_value;
}

//This function calculates a 4x4 pattern based on the opacity parameter.
//The opacity parameter works on a 0.0 - 1.0 range.
int patCalc(float opacity, int xPos, int yPos)
{
	opacity *= 16.0;
	//4x4 dither lookup table
    mat4 lookup = mat4(
		vec4(1.0 ,12.0,3.0 ,10.0),
        vec4(14.0,5.0 ,16.0,7.0 ),
        vec4(4.0 ,9.0 ,2.0 ,11.0 ),
        vec4(15.0,8.0 ,13.0,6.0 )
        );
	//Subtract the opacity from the lookup table's value, then add one make a 0 into a 1
	int retval = int((opacity - mat4_get(lookup, xPos, yPos, 0.0)) + 1.0);
	//Add the absolute value of retval so that negative values cancel out and end up being 0
	retval += int(abs(float(retval)));
	//Take the sign so that we end up with either 0 or 1
	retval  = int(sign(float(retval)));
    return retval;
}

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	//Loop our screen position between 0 and 3
    int xPos = int(mod(v_vPosition.x,4.0));
	int yPos = int(mod(v_vPosition.y,4.0));
	
	int dith = patCalc(gl_FragColor.a, xPos, yPos);
	
    gl_FragColor.a = float(dith) * sign(gl_FragColor.a);
}

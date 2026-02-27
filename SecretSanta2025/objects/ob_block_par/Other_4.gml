if start_on_wall 
{
	start_on_wall = false;
	var _left = raycast(x, y - 8, 180, 16, ob_col);
	if _left
	{
		stick_to(180, _left.id);
	}
	else 
	{
		var _right = raycast(x, y - 8, 0, 16, ob_col);
		if _right
		{
			stick_to(0, _right.id);
		}
	}
}
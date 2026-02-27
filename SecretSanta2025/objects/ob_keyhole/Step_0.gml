
if !is_unlocked
{
	if is_key_sequence
	{
		if key_sequence_time > key_sequence_dur
		{
			is_key_sequence = false;
			
			unlock();
		}
		else key_sequence_time++;
	}
	else 
	{
		var _key_left = collision_circle(x, y, 24, ob_key, false, false)
		if _key_left
		{
			_key_left.id.get_used();
			is_key_sequence = true;
		}
		//else 
		//{
		//	var _key_right = raycast(x, y, 0, 16, ob_key);
	
		//	if _key_right
		//	{
		//		_key_right.id.get_used();
		//		is_key_sequence = true;
		//	}
		//}

	}
}


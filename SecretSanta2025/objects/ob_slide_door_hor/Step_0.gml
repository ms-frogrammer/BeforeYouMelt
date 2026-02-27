var _signal = has_signal;
if opposite _signal = !has_signal;

if _signal 
{
	if flip 
	{
		if !place_meeting(x + spd, y, [ob_block_par, ob_plr]) x = min(x + spd, right);
	}
	else 
	{
		if !place_meeting(x - spd, y, [ob_block_par, ob_plr]) x = max(x - spd, left);
	}
	
}
else {
	if flip 
	{
		if !place_meeting(x - spd, y, [ob_block_par, ob_plr]) x = max(x - spd, left);
	}
	else 
	{
		if !place_meeting(x + spd, y, [ob_block_par, ob_plr]) x = min(x + spd, right);
	}
}

var _is_sliding = xprevious != x;
block.is_sliding = _is_sliding;
block.x = x + width/2;
image_index = _signal ? (_is_sliding ? 2 : 1) : 0;

slide_door_make_sound(_is_sliding, _signal);
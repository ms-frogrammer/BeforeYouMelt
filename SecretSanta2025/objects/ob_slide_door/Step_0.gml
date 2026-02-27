var _signal = has_signal;
if opposite _signal = !has_signal;

if _signal 
{
	if !place_meeting(x, y - spd, ob_block_par) y = max(y - spd, top );
}
else {
	if !place_meeting(x, y + spd, ob_block_par) y = min(y + spd, bottom);
}

var _is_sliding = yprevious != y;
block.is_sliding = _is_sliding;
block.y = bbox_bottom;
image_index = _signal ? (_is_sliding ? 2 : 1) : 0;

slide_door_make_sound(_is_sliding, _signal);
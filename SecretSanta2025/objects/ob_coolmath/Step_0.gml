time++;

if fade_in 
{
	if time > dur
	{
		fade_in = false;
		time = 0;
		opacity = 0;
	}
	else 
	{
		opacity = lerp(1, 0, time/dur);
	}
}
else if fade_out
{
	if time > dur
	{
		ob_room_handler.transition_to(rm_menu);
		opacity = 1;
	}
	else 
	{
		opacity = lerp(0, 1, time/dur);
	} 
}
else 
{
	if time >= 120
	{
		fade_out = true;
		time = 0;
		opacity = 0;
	}
}
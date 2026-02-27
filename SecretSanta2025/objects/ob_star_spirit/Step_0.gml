if place_meeting(x, y, ob_plr)
{
	global.stars++;
	vfx_create_cloud(x, y, sprite_index, c_white, 6, 2, 3, 0.01, -35, 0.5, 0.75, -0.01, 90, false);
	
	instance_destroy();
}

y = ystart + sin(current_time/1000 * 10) * 4;
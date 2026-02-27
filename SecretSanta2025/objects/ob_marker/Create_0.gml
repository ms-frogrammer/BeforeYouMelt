actor = noone;
reactor = noone;

scan = function()
{
	actor = instance_nearest(x, y, ob_actor_par);
	reactor = instance_nearest(x + lengthdir_x(image_xscale*16, image_angle), y + lengthdir_y(image_xscale*16, image_angle), ob_reactor_par);

	var _s = id;
	with actor
	{
		set_reactor(_s.reactor);
	}
}
call_later(2, time_source_units_frames, scan); 

return_data = function()
{
	return save_vars(id, ["x", "y", "image_xscale", "image_yscale", "image_angle"])
}
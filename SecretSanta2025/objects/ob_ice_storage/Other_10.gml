var _cx = camera_get_view_x(VIEW);
var _cy = camera_get_view_y(VIEW);
if parts_left > 0
{
	draw_sprite_ext(sprite_index, image_index, x - _cx, y - _cy, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}
else 
{	
	
	var _txt = "?";
	if time_left != - 1 
	{
		var _time = ceil(time_left / 60);
		_txt = string(_time);
	} 

	draw_set_color(CYAN);
	draw_set_font(fnt_main);
	draw_text(x - _cx, y - _cy - 6, _txt);
	draw_set_color(c_white);
}

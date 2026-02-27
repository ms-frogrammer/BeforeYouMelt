// - ABILITY PREDICTION

if !is_alive || !global.plr_input_enabled || !visualize_gui exit; // Stop drawing in case we died

var _alpha = 0.5 + sin(current_time/1000) * 0.25;
var _bx, _by, _bsize = 16, _bcol = GREEN;
var _cx = -camera_get_view_x(VIEW);
var _cy = -camera_get_view_y(VIEW);


if instance_exists(grab_block) && on_ground
{
	_bcol = ORANGE;
	draw_rectangle_color(grab_block.bbox_left+1 + _cx, grab_block.bbox_top + 1 + _cy, grab_block.bbox_right - 1 + _cx, grab_block.bbox_bottom - 1 + _cy, _bcol, _bcol, _bcol, _bcol, true);	

	//var _sy = y + 8;
}

if !can_stick _bcol = RED;
else _bcol = GREEN;


if instance_exists(predicting_block)
{
	_bx = x + _cx;
	_by = y - 8 + _cy + vsp;

	if predicting_dir == 270
	{
		// _bx = x;
		// _by = predicting_block.bbox_top - _bsize/2;

		if shift_to != 0
		{
			_bx = predicting_block.x + 16 * shift_to + _cx;
			_by = predicting_block.y - _bsize/2 + _cy;
		}
	}
	// else if predicting_dir == 0
	// {
	// 	_bx = predicting_block.bbox_left - _bsize/2;
	// 	_by = y;
	// }
	// else if predicting_dir == 180
	// {
	// 	_bx = predicting_block.bbox_right + _bsize/2;
	// 	_by = y;
	// }

	

	draw_rectangle_color(_bx - _bsize/2 + 1, _by - _bsize/2 + 1, _bx + _bsize/2 - 1, _by + _bsize/2 - 1, _bcol, _bcol, _bcol, _bcol, true);

	var _sy = y + _cy;
	var _sx = x + _cx + lengthdir_x(8, predicting_dir);
	//draw_circle_color(x, _sy, 2, _bcol, _bcol, false);
	var _dirx = _sx + lengthdir_x(8, predicting_dir);
	var _diry = y + _cy + lengthdir_y(8, predicting_dir);
	draw_set_color(_bcol);

	//draw_arrow(_sx, _sy, _dirx, _diry, 6);
}
else 
{
	if count_parts()>0 && ability_rate <= 0
	{
		draw_set_color(GREEN);
		draw_arrow(x + _cx, y + _cy + 4, x + _cx, y + _cy + 12, 8);
	}
}
draw_set_color(c_white);
draw_set_alpha(1)

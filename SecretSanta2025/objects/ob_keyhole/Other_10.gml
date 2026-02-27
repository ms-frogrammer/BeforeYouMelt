
if is_unlocked
{
	image_index = 1;
}

var _shake_x = 0;
var _shake_y = 0;
if instance_exists(door)
{
	_shake_x = door.myshake.x;
	_shake_y = door.myshake.y;
}
draw_sprite_ext(sprite_index, image_index, x + _shake_x - camera_get_view_x(VIEW), y + _shake_y - camera_get_view_y(VIEW), image_xscale, image_yscale, image_angle, image_blend, image_alpha)

if is_key_sequence
{
	var _prog = key_sequence_time/key_sequence_dur;
	var _x = x - 32 + AnimcurveTween(0, 24, acCubicIn, _prog) - camera_get_view_x(VIEW);
	draw_sprite(sp_key, 1, _x, y + 12 - camera_get_view_y(VIEW));
}
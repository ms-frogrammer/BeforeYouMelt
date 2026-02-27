
myshake.step();

// Stop drawing if the player is dead and has finished their animation
if death_done exit;


var _cx = camera_get_view_x(VIEW);
var _x = x - _cx;
var _y = y - count_parts()*16 + 16 - camera_get_view_y(VIEW);
var _head_x = x - _cx;

if count_parts() != 0
{
	_head_x = array_first(parts_x) - _cx;
    for(var i = 0; i < count_parts(); i++)
    {
        var _turn = (count_parts()-i)/count_parts();
        var _k = 0.25/(_turn);
        parts_hsp[i] += (_k * (x - parts_x[i]))*0.5;
		parts_hsp[i] *= 0.75;
        var _px = parts_x[i] + parts_hsp[i];
        set_part_x(_px, i); 
    }
}

_head_x += myshake.x;
var _head_y = _y - 15 + myshake.y;
draw_sprite_ext(sp_head, 0, _head_x, _head_y, face_x * squash_x[0], squash_y[0], head_tilt, c_white, 1);
if global.has_bird
{
    draw_sprite_ext(sp_bird, 0, _head_x + 1 + lengthdir_x(17, head_tilt + 90), _head_y + lengthdir_y(17, head_tilt + 90), face_x * squash_x[0], squash_y[0], head_tilt, c_white, 1)
}

for(var i = 0; i < count_parts(); i++)
{
	draw_sprite_ext(parts_spr[parts[i]], 0, parts_x[i] - _cx + myshake.x, _y + myshake.y, face_x * squash_x[i+1], squash_y[i+1], 0, c_white, 1);
	
	_y += 16// + vsp/2;
}

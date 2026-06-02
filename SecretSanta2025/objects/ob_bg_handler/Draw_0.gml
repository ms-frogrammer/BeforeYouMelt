
var _cx = camera_get_view_x(VIEW);
var _cy = camera_get_view_y(VIEW);

var _width = sprite_get_width(sp_bg_L0);

var _bg0 = sp_bg_L0;
var _bg1 = sp_bg_L1;
var _bg2 = sp_bg_L2;
var _bg3 = sp_bg_L3;
var _bg4 = sp_bg_L4

if global.is_night
{
    _bg0 = sp_night_bg_L0;
    _bg1 = sp_night_bg_L1;
    _bg2 = sp_night_bg_L2;
    _bg3 = sp_night_bg_L3;
    _bg4 = sp_night_bg_L4;
}

if global.is_sunrise
{
    _bg0 = sp_sunrise_bg_L0;
    _bg1 = sp_sunrise_bg_L0;
    _bg2 = sp_sunrise_bg_L2;
    _bg3 = sp_sunrise_bg_L3;
    _bg4 = sp_sunrise_bg_L4;
}


draw_sprite_ext(_bg0, 0, _cx, _cy, 1, 1, 0, c_white, 1);
draw_sprite_ext(_bg1, 0, _cx*0.9, _cy, 1, 1, 0, c_white, 1);
draw_sprite_ext(_bg2, 0, _cx*0.85 - _width, _cy, 3, 1, 0, c_white, 1);
draw_sprite_ext(_bg3, 0, _cx*0.75 - _width, _cy, 3, 1, 0, c_white, 1);

cloud_x += cloud_spd;
if cloud_x <= -640 cloud_x = 0;
draw_sprite_ext(_bg4, 0, cloud_x + _cx*0.9, _cy*0.9, 2, 1, 0, c_white, 1);

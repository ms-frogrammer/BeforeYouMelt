
if global.is_speedrun_mode
{
    var _str = frames_to_string(global.speedrun_clock);
    
    var _color = YELLOW;
    var _scrib = scribble("[fnt_main]" + "[fa_center][fa_top]" + _str);
    _scrib.blend(_color, 1);
    _scrib.draw(RES_W/2, 16);
}
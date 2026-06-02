if !global.game_paused
{
	var _color = WHITE_WARM;

	var _scrib = scribble("[fnt_main]" + "[wave][fa_left][fa_top]" + "|| esc");
	_scrib.blend(_color, 1);
	_scrib.draw(16, 16);
}
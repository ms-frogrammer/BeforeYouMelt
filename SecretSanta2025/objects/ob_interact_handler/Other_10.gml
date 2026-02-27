draw_set_halign(fa_center);
draw_set_valign(fa_middle);
	
var _txt = scribble("[fnt_small][wave][fa_center][fa_middle]" + icon_text);
scribble_anim_wave(2, 0.5, 0.1);
_txt.transform(scalex, 1, 0);
_txt.draw(icon_x, icon_y);

scalex = lerp(scalex, is_on, 0.15);

is_on = false;
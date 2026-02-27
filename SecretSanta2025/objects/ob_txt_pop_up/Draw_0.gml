
var _text = scribble(txt);

if blink_now {
	draw_set_halign(fa_center); draw_set_valign(fa_middle);
	_text.align(fa_center, fa_middle);
	_text.draw(x, y);
}

draw_set_halign(fa_left); draw_set_valign(fa_top);


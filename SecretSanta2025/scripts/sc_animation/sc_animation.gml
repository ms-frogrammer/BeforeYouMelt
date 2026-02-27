///@desc Calculates how many frames are needed to play a certain amount of frames for an animation at it's speed
function get_animation_duration(_frames_number, _anim) {
	return round(_frames_number/(sprite_get_speed(_anim)/60));
}

/// Return: Floating point number interpolated from <start> to <end> using the give animation curve as the lerping factor
/// 
/// @param start      Starting value
/// @param end        End value
/// @param animCurve  Animation curve to use
/// @param posx       x-position to read from

function animcurve_tween(_start, _end, _curve, _t)
{
    var _w = animcurve_channel_evaluate(animcurve_get_channel(_curve, 0), _t);
    var _value = lerp(_start, _end, _w);
    return _value;
}


function Shake() constructor {
	x = 0;
	y = 0;
	remain = 0;
	magnitude = 0;
	length = 0;
	
	function shake(_dur = 12, _str = 12) {
		magnitude = _dur;
		remain = _dur;
		length = _str;
	}
	
	function step() {
		remain = max(0, remain-((1/length)*magnitude));
		x = random_range(-remain, remain);
		y = random_range(-remain, remain);
	}
	
}
function Anim(_spr, _stop_on_end = false, _fps = undefined) constructor {
	spr = _spr;
	img = 0;
	FPS = _fps;
	stop_on_end = _stop_on_end;
	anim_end = false;
	
	function step() {
		if FPS == undefined FPS = sprite_get_speed(spr);
		
		var _game_spd = game_get_speed(gamespeed_fps);
		var _fpgf = FPS / _game_spd;

		img += _fpgf;
		if img >= sprite_get_number(spr) - _fpgf {
			if stop_on_end {
				FPS = 0;
				anim_end = true;
			}
			else img = 0;
		}
	
	}
	
	function play(_spr, _stop_on_end = false, _img = 0, _fps = -1){
		spr = _spr;
		img = _img;
		FPS = _fps;
		stop_on_end = _stop_on_end;
		
		if FPS == -1 FPS = sprite_get_speed(spr);
	}
}

function draw_dotted_line(_x1, _y1, _x2, _y2, _anim, _color = c_white, _alpha = 1) {
	var _length = point_distance(_x1, _y1, _x2, _y2)/32;
	var _x = _x1 + (_x2 - _x1)/2;
	var _y = _y1 + (_y2 - _y1)/2;

	draw_sprite_ext(_anim.spr, _anim.img, _x, _y, _length, 1, point_direction(_x1, _y1, _x2, _y2), _color, _alpha);
}
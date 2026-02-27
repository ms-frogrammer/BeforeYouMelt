#macro VFX_DEPTH layer_exists("Effects") ? (layer_get_depth(layer_get_name("Effects"))) :  (layer_get_depth(layer_get_name("Instances")) - 1)

function vfx_create_anim(_x, _y, _sprite, _destroy_on_end_or_duration, _xscale = 1, _yscale = 1, _angle = 0) {

	//if layer_exists(layer_get_id("fg_objects")) _depth = layer_get_depth(layer_get_id("fg_objects"));
	var _effect = instance_create_depth(_x, _y, VFX_DEPTH, ob_anim);
	_effect.sprite_index = _sprite;
	_effect.image_xscale = _xscale;
	_effect.image_yscale = _yscale;
	_effect.image_angle = _angle;
	_effect.parent = id;
	if _destroy_on_end_or_duration == 1 {
		_effect.destroy_on_end = true;
	}
	else _effect.lifetime = _destroy_on_end_or_duration;
	
	return _effect;
}

function vfx_create_particle(_x, _y, _spr, _scale_x = 1, _scale_y = 1, _time = -1) {
	var _effect = instance_create_depth(_x, _y, VFX_DEPTH, ob_particle);
	with _effect {
		time = _time;
		sprite_index = _spr;

		scale_x = _scale_x; scale_y = _scale_y;
		image_xscale = scale_x; image_yscale = scale_y; 
	}
	_effect.parent = id;
	
	return _effect;
}

function vfx_create_particle_ext(_x, _y, _spr, _destroy_on_anim_end = false, _vel_x = 0, _vel_y = 0, _scale_x = 1, _scale_y = 1, _scale_spd_x = 0, _scale_spd_y = 0, _angle_spd = 0, _time = -1, _move_in_dir = false, _dir = 0, _spd = 0, _decell = 0) {
	var _effect = instance_create_depth(_x, _y, VFX_DEPTH, ob_particle);
	with _effect {
		time = _time;
		
		sprite_index = _spr;
		destroy_on_anim_end = _destroy_on_anim_end;
		
		dir = _dir;
		spd = _spd;
		decell = _decell;
		
		move_in_dir = _move_in_dir;
		angle_spd = _angle_spd;

		vel_x = _vel_x;
		vel_y = _vel_y;

		scale_x = _scale_x; scale_y = _scale_y;
		image_xscale = scale_x; image_yscale = scale_y; 
		scale_spd_x = _scale_spd_x;
		scale_spd_y = _scale_spd_y;
	}
	_effect.parent = id;
	
	return _effect;
}
function vfx_set_extra(_effect, _color = c_white, _destroy_on_scale = true, _angle_to_vel = false, _fade_spd = 0, _stay_on_index = -1, _set_angle = -1) {
	with _effect {
		image_blend = _color;
		destroy_on_scale = _destroy_on_scale;
		angle_to_vel = _angle_to_vel;
		fade_spd = _fade_spd;
		stay_on_index = _stay_on_index;
		set_angle = _set_angle;
	}
	
}

/*
function effect_create(_sprite, _pos, _vel, _collide_on, _vel_slow_down_bool, _vel_slow_speed, _angle_to_vel_bool, _angle_spin_speed, _scale_vec, _scale_vel_vec, _destroy_on_scale, _lifetime, _fade_alpha_speed = 0, _depth = 0) {
	var _effect = instance_create_layer(_pos.x, _pos.y, "Effects", o_effect);
	with _effect {
		sprite_index = _sprite;
		
		vel = _vel;
		vel_collide = _collide_on;

		vel_slow_down = _vel_slow_down_bool;
		vel_slow_speed = _vel_slow_speed;

		angle_to_vel = _angle_to_vel_bool;
		angle_spin_speed = _angle_spin_speed;

		scale = _scale_vec;
		scale_vel = _scale_vel_vec;
		destroy_on_scale = _destroy_on_scale;

		lifetime = _lifetime;
		fade_alpha_speed = _fade_alpha_speed;
		
		if _depth != 0 depth = _depth;
		
		image_xscale = _scale_vec.x;
		image_yscale = _scale_vec.y;
	}
	
	return _effect;
	
}
*/

function vfx_create_cloud(_x, _y, _spr, _color, _amount, _min_spd, _max_spd, _decell_spd, _spin_spd, _min_scale, _max_scale, _scale_vel, _lifetime, _destroy_on_anim_end = false, _fade_spd = 0) {
	for(var i = 0; i < _amount; i++) {
		var _dir = 360/_amount * i + random_range(-25, 25);

		var _newscale = random_range(_min_scale, _max_scale);
		var _newx = _x + lengthdir_x(_newscale, _dir);
		var _newy = _y + lengthdir_y(_newscale, _dir);
	
		var _effect = vfx_create_particle_ext(_newx, _newy, _spr, _destroy_on_anim_end, 0, 0, _newscale, _newscale, _scale_vel, _scale_vel, _spin_spd, _lifetime, true, _dir, random_range(_min_spd, _max_spd), _decell_spd);
		vfx_set_extra(_effect, _color, true, false, _fade_spd, false, _dir - 90);
	}
	

}

function vfx_preset_blood_cloud(_x, _y, _color = c_red) {
	vfx_create_particle(_x, _y, sp_effect_circle_empty, 1.5, 1.5, 3).image_blend = _color;
	vfx_create_cloud(_x, _y, sp_effect_circle, _color, 12, 1, 3, 5/30, 0, 0.2, 0.4, -0.5/90, 90, true);
	vfx_create_cloud(_x, _y, sp_effect_wave, _color, 4, 3, 5, 5/30, 0, 1, 2, -2/90, 60, true);
}

function vfx_preset_frozen_cloud(_x, _y, _color = c_white) {
	vfx_create_cloud(_x, _y, sp_vfx_ice, _color, 8, 1, 3, 3/30, -10, 0.5, 0.75, -0.75/120, 120, true);
}


function vfx_txt_pop(_x, _y, _txt, _blink_number, _blink_rate, _parent = noone, _xoffset = 0, _yoffset = 0) {
	var _pop_up = instance_create_layer(_x, _y, "GUI", ob_txt_pop_up);
	_pop_up.txt = _txt;
	_pop_up.blink_number_max = _blink_number;
	_pop_up.blink_rate_max = _blink_rate;
	_pop_up.parent = _parent;
	_pop_up.xoffset = _xoffset;
	_pop_up.yoffset = _yoffset;
	return _pop_up;
}
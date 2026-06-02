/// @feather disable all
enum BG_PARTICLES 
{
	SNOW,
	LEAF
}

particles = [];
particle_number = 25;

wind_dir = 180;
dir_var = 30;
wind_spd = 4;

spawn_margin = 16;
spawn_xoff = 0;
spawn_yoff = 0;
draw_spawn = false;


init_particles = function(_num)
{
	repeat(_num)
	{
		var _p = new_particle(BG_PARTICLES.SNOW, random_range(0, room_width), random_range(0, room_height), -2, 0, wind_dir + random_range(-dir_var/2, dir_var), wind_spd);
		save_particle(_p);
		
		log("add particle");
	}
}


new_particle = function(_type, _x, _y, _hsp, _vsp, _dir, _spd)
{
	return {
		id : -1,
		type : _type,
		x : _x,
		y : _y,
		hsp : _hsp,
		vsp : _vsp,
		dir : _dir,
		spd : _spd * random_range(0.75, 1.25),
	}
}

empty_positions = [];
save_particle = function(_particle)
{
	var _new_pos = -1;
	var _wid = array_length(empty_positions);
	// Has an empty slot
	if _wid > 0 
	{
		_new_pos = empty_positions[0];
		_particle.id = _new_pos;
		particles[_new_pos] = _particle;
		array_delete(empty_positions, 0, 1);
	}
	else {
		_new_pos = array_length(particles)
		_particle.id = _new_pos;
		array_push(particles, _particle);
	}
}

delete_particle = function(_particle)
{
	var _pos = _particle.id;
	particles[_pos] = undefined;
	array_push(empty_positions, _pos);
}
draw_particle = function(_particle)
{

	switch(_particle.type)
	{
		case BG_PARTICLES.SNOW:
			var _col = color;
			var _cx = camera_get_view_x(VIEW);
			var _cy = camera_get_view_y(VIEW);
			var _px = _particle.x - _cx;
			var _py = _particle.y - _cy;
			
			draw_rectangle_color(_px - _cx, _py - _cy, _px - _cx + 1, _py - _cy + 1, _col, _col, _col, _col, false);
			//draw_sprite_ext(sp_pixel, 0, floor(_px), floor(_py), 1, 1, 0, _col, 1);
			if wind_spd > 2
			{
				_px -= _particle.hsp/2;
				_py -= _particle.vsp/2;
				draw_rectangle_color(_px - _cx, _py - _cy, _px - _cx + 1, _py - _cy + 1, _col, _col, _col, _col, false);
				//draw_sprite_ext(sp_pixel, 0, floor(_px), floor(_py), 1, 1, 0, _col, 1);
			}
			
			break;
	}
}

particles_to_delete = [];
move_particle = function(_id)
{
	var _p = particles[_id];
	var _s = id;
	var _marg = spawn_margin;
	with _p
	{
		hsp = lengthdir_x(spd, dir);
		x += hsp;
		vsp = lengthdir_y(spd, dir);
		y += vsp;

		if !point_in_rectangle(x, y, -_marg, -_marg, room_width + _marg, room_height + _marg) 
		{
			array_push(_s.particles_to_delete, _id);
		}
	}
}

init_particles(particle_number);


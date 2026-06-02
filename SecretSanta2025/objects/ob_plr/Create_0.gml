// Make sure this isn't an extra player
if global.plr_id != noone {
	instance_destroy();
	return;
}
else global.plr_id = id;


states_setup("idle");

// - INPUT
	r_input = {};
// -

// - GENERAL
is_alive = true;

// - DEATH
	dmg_rate = 0;
	dmg_rate_max = 30;

	death = function()
	{
		is_alive = false;
		global.plr_input_enabled = false;

		var _f = function()
		{
			ob_room_handler.reload_room();
		}
		call_later(30, time_source_units_frames, _f);
	}

	damage = function()
	{
		if dmg_rate > 0 || death_done exit;
		dmg_rate = dmg_rate_max;
		
		var _block_num = array_length(parts)-1;
		var _vfx_x = x;
		var _vfx_y = y;

		if count_parts() > 0
		{
			// Crate is the only tile that doesn't pop!
			if parts[_block_num] == BLOCK_TYPE.CRATE exit;

			if parts[_block_num] == BLOCK_TYPE.ICE
			{
				// Return to the storage block
				with array_last(storage_ids) refill();
				array_pop(storage_ids);
			}
			
			_vfx_x = parts_x[_block_num];

			lose_part();
			update_mask();

		}
		else 
		{
			if !death_done
			{
				death_done = true;
				death();
			}
			
		}

		vfx_create_anim(_vfx_x, _vfx_y, sp_effect_block_pop, true, choose(-1, 1), 1, 0);
		vfx_create_cloud(_vfx_x, _vfx_y - 8, sp_white, c_white, 5, 1.5, 2.5, 0.025, 0, 0.15, 0.33, -0.01, 120, false);
		myshake.shake(4, 10);

		snd_play_rndpitch(sfx_grab_2);
	}

	death_done = false;

// - MOVEMENT
	// - face
		face_x = 1;
		update_face_x = function()
		{
			if hsp != 0 face_x = sign(hsp);
		}
	// - acc
		acc = 0;
		ground_acc = 0.25;
		air_acc = 0.15;

		get_acc = function()
		{
			return on_ground ? ground_acc : air_acc;
		}
	// - move
		hsp = 0;
		vsp = 0;
		stay_on_edge = false;
		move_spd = 2;
		move = function()
		{
			var _targ_hsp = r_input.hor * move_spd;
			hsp += clamp(_targ_hsp - hsp, -acc, acc);

			if stay_on_edge
			{
				if !place_meeting(x + hsp, y + 2, [ob_col, ob_block_par]) 
				{
					hsp = 0;
				}
			}
			
		}
	// - falling and ground
		get_weight = function()
		{
			var _extra = 0;
			for(var i = 0; i < count_parts(); i++)
			{
				_extra += parts_weight[parts[i]];
			}
			return 1 + _extra;
		}
		grav = 0.3;

		landed = false;
		land = function()
		{
			snd_play(sfx_snow_3, false);
		}
		
		on_ground = false;
		get_on_ground = function()
		{
			return place_meeting(x, y + 2, [ob_col, ob_block_par]) || on_semisolid;
		}
	// - jump
		force_jump = false;
		jump_init_pow = -2.5;
		jump_time = 0;
		jump_time_max = 8;
		jump_force = -2;
		jump_buffer = 0;
		jump_buffer_max = 10;
		mini_jump_pow = -3;

		coyote_time = 0;
		coyote_dur = 10;

	// - semisolid
		on_semisolid = noone;
		ignore_semisolid_frames = 0;
		semisolid_tick = function()
		{
			on_semisolid = noone;
			if ignore_semisolid_frames <= 0 {
				for(var _y = y; _y <= y + max(ceil(vsp), 2); _y++)
				{
					
					var _semisolid = collision_rectangle(x - 8, _y, x + 8, _y + 1, ob_semisolid, false, false);
					if _semisolid 
					{
						if round(bbox_bottom) < round(_semisolid.bbox_top) && 
						round(bbox_bottom) + vsp > round(_semisolid.bbox_top) {
							vsp = 0;
							y = y + (_semisolid.bbox_top - bbox_bottom);
							on_semisolid = _semisolid; 
						}
						else if round(bbox_bottom) == round(_semisolid.bbox_top) && vsp > 0 {
							vsp = 0;
							on_semisolid = _semisolid
						}
						break;
					}
				}
			}
		}
// -

// - MASK
	mask_index = sp_body;
	update_mask = function()
	{
		image_yscale = count_parts() + 0.5;
	}
// -


// - PARTS
	
	squash_x = [1];
	squash_y = [1];

	squeeze = function(_x, _y, _number)
	{
		squash_x[_number] = _x;
		squash_y[_number] = _y;
	}
	
	parts_x = [];
	set_part_x = function(_value, _number)
	{
		parts_x[_number] = _value;
	}
	parts_hsp = [];
	set_part_hsp = function(_value, _number)
	{
		parts_hsp[_number] = _value;
	}

	count_parts = function()
	{
		return array_length(parts);
	}

	add_part = function(_type)
	{
		array_push(parts, _type);
		
		array_push(squash_x, 1);
		array_push(squash_y, 1);

		array_push(parts_x, x);
		array_push(parts_hsp, 0);
		
		squeeze(1.25, 1.25, count_parts()-1);
		update_mask();
	}

	lose_part = function()
	{
		array_pop(parts);
		array_pop(squash_x);
		array_pop(squash_y);
		array_pop(parts_hsp);
		array_pop(parts_x);
	}

	// - TYPES
		enum BLOCK_TYPE
		{
			SNOW, 
			CRATE,
			ICE,
			KEY,
			STORAGE,
		}

		// Object
		parts_obj[BLOCK_TYPE.SNOW] = ob_block_par;
		parts_obj[BLOCK_TYPE.CRATE] = ob_crate;
		parts_obj[BLOCK_TYPE.ICE] = ob_ice;
		parts_obj[BLOCK_TYPE.KEY] = ob_key;

		// Sprite
		parts_spr[BLOCK_TYPE.SNOW] = sp_body;
		parts_spr[BLOCK_TYPE.CRATE] = sp_crate;
		parts_spr[BLOCK_TYPE.ICE] = sp_ice_decay;
		parts_spr[BLOCK_TYPE.KEY] = sp_key;

		// Can stick
		parts_can_stick[BLOCK_TYPE.SNOW] = true;
		parts_can_stick[BLOCK_TYPE.CRATE] = false;
		parts_can_stick[BLOCK_TYPE.ICE] = true;
		parts_can_stick[BLOCK_TYPE.KEY] = true;

		// Weight
		parts_weight[BLOCK_TYPE.SNOW] = 0.05;
		parts_weight[BLOCK_TYPE.CRATE] = 0.15;
		parts_weight[BLOCK_TYPE.ICE] = 0.05;
		parts_weight[BLOCK_TYPE.KEY] = 0.15;

		// Sound
		parts_sound[BLOCK_TYPE.SNOW] = undefined;
		parts_sound[BLOCK_TYPE.CRATE] = sfx_crate;
		parts_sound[BLOCK_TYPE.ICE] = sfx_ice_place;
		parts_sound[BLOCK_TYPE.KEY] = undefined;
	// -
	
	parts = [];
		add_part(BLOCK_TYPE.SNOW);
		add_part(BLOCK_TYPE.SNOW);
	storage_ids = [];

	// - RELEASE/GRAB
		ability_rate = 0;
		ability_rate_max = 5;
		throw_spd = 3;

		predicting_dir = 0;
		predicting_block = noone;
		cant_stick = false;
		grab_block = noone;

		shift_to = 0;
		can_stick = false;

		stuck_on_new_mask = function(_block)
		{
			var _s = id;
			with _block.block
			{
				return collision_rectangle(_s.x - 8, _s.bbox_bottom, _s.x + 8, _s.bbox_bottom + 16, ob_col, false, true);
			}
		}

		predict_grab = function() {
			grab_block = noone;
			
			
			var _block = noone;
			var _ice_block = noone;

			var _l = ds_list_create();


			if collision_circle_list(x, y + 1, 8, ob_ice_storage, false, false, _l, true)
			{
				foreach _l elem
					if _elem.can_take() 
					{
						_ice_block = _elem;
						break;
					}
				end
			}

			if _ice_block {
				_block = _ice_block;
			}
			else {
				if count_parts() > 0 _block = instance_place(x, y + 8, ob_block_par);
				else _block = collision_circle(x, y - 8, 12, ob_block_par, false, false);
			}

			if _block
			{
				var _cancel = false;
				image_yscale = count_parts() + 1 + 0.5;

				if _ice_block
				{
					if place_meeting(x, y, ob_col) 
					{
						_cancel = true;
					}

					var _collides_above = place_meeting(x, y - 16, [ob_block_par, ob_col]);

					with ob_block_par
					{
						if id != _block.id
						{
							if place_meeting(x, y, ob_plr)
							{
								if _collides_above
								{
									_cancel = true;
								}
								//_cancel = true;
							} 
						}
					}
				}
				else 
				{
					var _orig_y = y;
					y += _block.bbox_bottom - bbox_bottom - 1;

					if place_meeting(x, y, ob_col) 
					{
						_cancel = true;
					}

					var _collides_above = place_meeting(x, y - 16, [ob_block_par, ob_col]);
					with ob_block_par
					{
						if id != _block.id
						{
							if place_meeting(x, y, ob_plr)
							{
								if _collides_above
								{
									_cancel = true;
								}
								//_cancel = true;
								
							} 
						}
					}

					y = _orig_y;
				}

				// Set collider back to default
				update_mask();

				if _cancel
				{
					exit;
				}

				grab_block = _block;
			}
		
		}

		grab = function() {
			//if place_meeting(x, y - 16, ob_col) exit;
			var _grabbed = false;

			coyote_time = 0;
			jump_buffer = 0;

			if grab_block.type == BLOCK_TYPE.STORAGE 
			{
				if grab_block.take()
				{
					array_push(storage_ids, grab_block.id);
					add_part(BLOCK_TYPE.ICE);

					landed = true;
					
					snd_play_rndpitch(sfx_grab_2);
					snd_play_rndpitch(sfx_ice_place);

					_grabbed = true;
				}
			}
			else 
			{
				if on_semisolid y -= 1;

				if grab_block.type == BLOCK_TYPE.ICE
				{
					array_push(storage_ids, grab_block.storage_id);
					snd_play_rndpitch(sfx_ice_place);
				} 
				
				add_part(grab_block.type);
		
				y += grab_block.bbox_bottom - bbox_bottom - 1;

				landed = true;
				snd_play_rndpitch(sfx_grab_2);

				instance_destroy(grab_block);

				_grabbed = true;
			}
			
			while(place_meeting(x, y, [ob_col, ob_block_par]))
			{
				y-=1;
			}

			if _grabbed
			{
				// Save game
				update_room_data();
			}
		}

		predict_ability = function()
		{
			predicting_block = noone;
			can_stick = true;
			shift_to = 0;
			stay_on_edge = false;

			if count_parts() <= 0 exit;
		
			// Under
			predicting_dir = 270;
			for(var _y = y; _y < y + 8; _y++)
			{
				var _block = instance_place(x, _y, [ob_col, ob_block_par]);

				var _semisolid = instance_place(x, _y, ob_semisolid);
				if _semisolid 
				{
					if y <= _semisolid.bbox_top _block = _semisolid;
				}
				
				if _block
				{
					
					predicting_block = _block;

					if instance_place(x, _y, [ob_sticky_par, ob_block_par])
					{
						if r_input.ver > 0 || r_input.shift_hold
						{
							stay_on_edge = true;
							var _dir = sign(x - predicting_block.x);
							if !collision_point(predicting_block.x + 16 * _dir, predicting_block.y - 8, [ob_col, ob_block_par], false, false)
							{
								shift_to = _dir;
							}
						}
						// else if !raycast(floor(x), floor(y), 270, 8, ob_col, ob_block_par) && on_ground
						// {	
						// 	if floor(x - predicting_block.x) >= 6
						// 	{
						// 		shift_to = 1;
						// 	}
						// 	else if floor(x - predicting_block.x) <= -6
						// 	{
						// 		shift_to = -1;
						// 	}
						// }
					}
					exit;
				}
			}

			var _x = x;
			var _y = y;
			var _list = ds_list_create();

			// Make sure the part can stick to walls before predicting placing it there
			can_stick = parts_can_stick[array_last(parts)];
		
			// To the right
			predicting_dir = 0;
			if collision_rectangle_list(_x, _y, _x + 16, _y+8, [ob_sticky_par, ob_block_par], true, true, _list, true)
			{
				predicting_block = _list[| 0];
				ds_list_destroy(_list);
				exit;
			}
			
			// To the left
			predicting_dir = 180;
			if collision_rectangle_list(_x - 16, _y, _x, _y+8, [ob_sticky_par, ob_block_par], true, true, _list, true)
			{
				predicting_block = _list[| 0];
				ds_list_destroy(_list);
				exit;
			}
		}

		ability = function()
		{
			if count_parts() <= 0 exit;

			var _BLOCK_TYPE = array_last(parts);
			var _obj = parts_obj[_BLOCK_TYPE];

			// Remove block
			lose_part();
			update_mask();
			landed = true;
			
			if instance_exists(predicting_block) && can_stick
			{
				var _y = ceil((y - 16) / 16) * 16 + 16;
				if predicting_block.object_index == ob_block_par 
				|| object_get_parent(predicting_block.object_index) == ob_block_par
				|| predicting_block.object_index == ob_semisolid
				{
					_y = predicting_block.y;
				}

				var _part = instance_create_layer(x, _y, "Instances", _obj);
				
				if !on_ground shift_to = 0;

				if shift_to != 0
				{
					predicting_dir = shift_to == 1 ? 180 : 0;

					shift_to = 0;
					_part.y = predicting_block.y;
				}

				_part.stick_to(predicting_dir, predicting_block);

				if _BLOCK_TYPE == BLOCK_TYPE.ICE
				{
					// Return to the storage block
					_part.storage_id = array_last(storage_ids);
					array_pop(storage_ids);
				}

				y += _part.bbox_top - bbox_bottom - 1;
				vsp = 0;
				
				if place_meeting(x, y, _part)
				{
					grab_block = _part;
					grab();
					exit;
				}
				
				snd_play_rndpitch(sfx_place_2);
				var _snd = parts_sound[_BLOCK_TYPE];
				if _snd snd_play_rndpitch(_snd);

				// Save game
				update_room_data();

				exit;
			}
			else 
			{

				// Drop
				var _yoff = sprite_get_height(sp_body);
				var _vsp = 0;
				if vsp > 0 _vsp = vsp;
	
				var _part = instance_create_layer(x, y + _vsp + _yoff, "Instances", _obj);
				_part.fall(_vsp);
				if _BLOCK_TYPE == BLOCK_TYPE.ICE
				{
					// Pass on the storage id
					_part.storage_id = array_last(storage_ids);
					array_pop(storage_ids);
				}
				
				force_jump = true;
				
				snd_play_rndpitch(sfx_place_2);
				var _snd = parts_sound[_BLOCK_TYPE];
				if _snd snd_play_rndpitch(_snd);

				// Save game
				update_room_data();
			}
		}	
	// -

	restart = function()
	{

		is_alive = true;
		death_done = false;

		global.plr_input_enabled = true;

		for(var i = 0; i < count_parts(); i++)
		{
			lose_part();
		}

		parts = [];
		storage_ids = [];
		parts_x = [];
		parts_hsp = [];
		squash_x = [1];
		squash_y = [1];

		add_part(BLOCK_TYPE.SNOW);
		add_part(BLOCK_TYPE.SNOW);

	}

// -

myshake = new Shake();

draw_arms = function()
{
	if count_parts() > 0 
	{
		var _x = array_first(parts_x) - camera_get_view_x(VIEW);
		var _y = y - count_parts()*16 + 16 - camera_get_view_y(VIEW);
		draw_sprite_ext(sp_arms, 0, _x, _y - 8, image_xscale, 1, 0, c_white, 1);
	}
}

particle_rate = 0;


// - TUTORIAL
	show_tutorial_message = false;
	if room == rm_1 && !global.is_speedrun_mode
	{
		global.plr_tutorial = true;
		global.tutorial_number = 0;
		show_tutorial_message = true;
	}
	
	tutorial_text = "";
	tutorial_delay = 0;

	set_tutorial_text = function(_spr, _text)
	{
		tutorial_text = "[" + sprite_get_name(_spr) + "]" + "[#F9F5D2]" + _text;
	}

	set_tutorial_text(sp_place_icons, " to place blocks");

	update_tutorial_text = function()
	{
		//show_tutorial_message = false;
		switch(global.tutorial_number)
		{
			case PLAYER_TUTORIAL.PLACE:
				set_tutorial_text(sp_place_icons, " to place blocks");
				break;

			case PLAYER_TUTORIAL.GRAB:
				set_tutorial_text(sp_grab_icons, " to grab blocks");
				break;

			case PLAYER_TUTORIAL.MOVE:
				tutorial_text = "[" + sprite_get_name(sp_w_icon) + ", " + string(global.tutorial_move.up) + "]";
				tutorial_text += "[" + sprite_get_name(sp_a_icon) + ", " + string(global.tutorial_move.left) + "]";
				tutorial_text += "[" + sprite_get_name(sp_s_icon) + ", " + string(global.tutorial_move.down) + "]";
				tutorial_text += "[" + sprite_get_name(sp_d_icon) + ", " + string(global.tutorial_move.right) + "]";
				tutorial_text += "[" + sprite_get_name(sp_joystick_icon) + "]";
				
				tutorial_text += "[#F9F5D2]" + " to move";
				break;

			case PLAYER_TUTORIAL.JUMP:
				set_tutorial_text(sp_jump_icons, " to jump");
				break;
		}
		
		//call_later(30, time_source_units_frames, display_tutorial_message);
	}

	switch_tutorial = function(_number)
	{
		global.tutorial_number = _number;
		update_tutorial_text();

		tutorial_delay = 45;
		myshake.shake(5, 10);
	}

start_x = 0;
start_y = 0;

save_start_pos = function()
{
	start_x = x;
	start_y = y;
}
load_start_pos = function()
{
	x = start_x;
	y = start_y;
}

save_start_pos();

visualize_gui = true;

head_tilt = 0;

return_data = function()
{
	var _vars = [
		"x", 
		"y", 
		"face_x", 
		"parts",
		"storage_ids",
		"parts_x", 
		"parts_hsp",
		"squash_x", 
		"squash_y", 
		"start_x", 
		"start_y",
	];

	return save_vars(id, _vars);
}

if room != rm_init && room != rm_coolmath
{
	// Load room data
		var _rm_name = room_get_name(room);
		if !is_undefined(ds_map_find_value(global.room_data, _rm_name))
		{
			var _data = global.room_data[? _rm_name];
			global.is_night = _data.is_night;
			global.has_bird = _data.has_bird;
			global.is_sunrise = _data.is_sunrise;
			global.is_windy = _data.is_windy;

			var _track = _data.bg_track;
			if _track != undefined
			{
				var _new_track = true;
				
				// Fade out the previous track
				if global.bg_track
				{	
					if audio_is_playing(global.bg_track)
					{
						if audio_sound_get_asset(global.bg_track) != _data.bg_track
						{
							audio_sound_gain(global.bg_track, 0, 2000);
							old_track = global.bg_track;
							call_later(2, time_source_units_seconds, stop_old_track);
							
							_new_track = true;
						}
						else _new_track = false;
					}
				}
	
				if _new_track
				{
					// Start the new track
					global.bg_track = audio_play_sound(_data.bg_track, 0, true);
				}	
			}
			else 
			{
				if global.bg_track
				{
					// Stop playing the current track
					if audio_is_playing(global.bg_track)
					{
						audio_sound_gain(global.bg_track, 0, 2000);
						old_track = global.bg_track;
						call_later(2, time_source_units_seconds, stop_old_track);
						global.bg_track = noone;
					}
				}	
			}
			
			

			if _rm_name == "rm_15"
			{
				// if !audio_is_playing(music_main)
				// {
				// 	audio_play_sound(music_main, 0, true);
				// }
				audio_stop_sound(music_bym_dialogue);
			}

			// Let coolmath know which level number has started
			var _lvl_num = ds_list_find_index(global.room_order, room);
			coolmathCallLevelStart(_lvl_num);

			// - SAVE GAME
				global.at_room = room;

				clear_room_info();
				save_game();
			// -
		}
	// -

	for(var i=0; i < array_length(create_each_room); i++)
	{
		if !instance_exists(create_each_room[i])
		{
			instance_create_depth(0, 0, 0, create_each_room[i]);
		}
		
		
	}

	if layer_exists("Tiles_1")
	{
		depth = layer_get_depth(layer_get_id("Tiles_1")) + 1;
		tile_generate_col_map(room_width, room_height, TILE, TILE_DEFAULT_TILEMAP_NAME);
	}
	
	
	front = instance_create_depth(0, 0, 0, ob_bg_particle_handler);
	back = instance_create_depth(0, 0, 0, ob_bg_particle_handler);
	back.wind_spd = 2;
	back.color = #a7acba;
	back.color = #accdec;

	
	// Place player at the right entrance/exit
	if instance_exists(ob_plr) {
		
		if exit_id != -1 {
			with ob_exit {
				if image_index == other.exit_id {
					if global.plr_exit_dir == 0 || global.plr_exit_dir == 2 {
						ob_plr.x = clamp(x, 4, room_width - 4);
						ob_plr.y = bbox_bottom;
					}
					else if global.plr_exit_dir == 1 || global.plr_exit_dir == 3 {
						ob_plr.x =  clamp(x - global.plr_to_exit_x, bbox_left + 8, bbox_right - 8);
						ob_plr.y = clamp(y, 4, room_height - 4);

						if global.plr_exit_dir == 1 ob_plr.y -= 8;
					}
				}
			}

			ob_plr.restart();
			ob_plr.save_start_pos();
			ob_cam.snap_to_target();
		}
	}
	else {
		my_debug_warning("No player found in the room! Creating a new player.");

		with ob_exit {
			if image_index == 0 {
				instance_create_layer(clamp(x, 4, room_width - 4), clamp(y, 4, room_height - 4), "Instances", ob_plr);
			}
		}
	}
	
	if !audio_is_playing(sfx_winter_ambience) snd_play(sfx_winter_ambience, true);
	if !audio_is_playing(sfx_wind_whistle) snd_play(sfx_wind_whistle, true);
	
	// Switch to night

	// if layer_background_get_sprite(layer_background_get_id(layer_get_id("Background"))) == sp_night_bg_full
	// {
	// 	global.is_night = true;
	// }

}


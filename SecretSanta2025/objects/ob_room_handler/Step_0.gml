if is_transitioning
{
	global.plr_input_enabled = false;
	global.transition_fade = min(global.transition_fade + fade_spd, 1);

	if global.transition_fade >= 1
	{
		is_transitioning = false;
		global.plr_input_enabled = true;

		if is_reloading {
			// - RESTART THE ROOM
				room_restart();

				ob_plr.load_start_pos();
				ob_plr.restart();	
			// -
		}
		else {
			// - GO TO THE NEXT ROOM
				room_goto(to_room);
			// -
		}
	}
}
else 
{
	global.transition_fade = max(global.transition_fade - fade_spd, 0);

	if global.plr_input_enabled
	{
		if input_check_pressed("restart")
		{
			load_room_data();
		}
		else if input_check("restart")
		{
			restart_held++;

			if restart_held >= 60 
			{
				reload_room();
			}
		}
		else restart_held = 0;
	}
	

	if global.transition_fade <= 0 
	{
		if !global.game_ending 
		{
			global.speedrun_clock++;
		}
		
	}
}

if !global.is_windy 
{
	audio_pause_sound(sfx_wind_whistle);
	audio_pause_sound(sfx_winter_ambience);
}
else 
{
	audio_resume_sound(sfx_wind_whistle);
	audio_resume_sound(sfx_winter_ambience);
}

if instance_exists(ob_ice)
{
	if ice_snd != noone
	{
		if !audio_is_playing(ice_snd) ice_snd = snd_play(sfx_ice_cracking, true);
	}
	else 
	{
		ice_snd = snd_play(sfx_ice_cracking, true);
	}
}
else 
{
	if ice_snd != noone
	{
		if audio_is_playing(ice_snd) audio_stop_sound(ice_snd);
		ice_snd = noone;
	}
}

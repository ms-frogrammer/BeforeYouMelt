is_available = !global.campfire_dialogue;

text_id = CAMPFIRE_1;

start = function()
{
	is_available = false;
	
	global.is_night = true;
	global.campfire_dialogue = true;
	global.plr_input_enabled = false;
 
	sprite_index = sp_campfire_scene;

	// - SKIP THE SCENE FOR SPEEDRUNNING
		if global.is_speedrun_mode
		{
			finish_scene();
			exit;
		}
	// -
	
	ob_plr.x = 176;
	ob_plr.restart();
	
	call_later(2, time_source_units_seconds, load_dialogue);
	
	audio_stop_sound(music_main);
	global.bg_track = audio_play_sound(music_bym_dialogue, 1, false);
}

load_dialogue = function()
{
	ob_dialogue_handler.begin_talk(id, false);
}

end_talk = function(){
	global.plr_input_enabled = false;

	call_later(2,  time_source_units_seconds, finish_scene);
}

finish_scene = function()
{
	global.plr_input_enabled = true;
	global.is_windy = false;
	ob_plr.visualize_gui = false;

	sprite_index = sp_campfire;

	room_goto(rm_12);
	
}
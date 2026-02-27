
function set_global_vars()
{
	// Player's relative position to room's exit preserved for the entrance in the next troom
	global.plr_to_exit_x = 0;
	global.plr_to_exit_y = 0;
	global.plr_exit_dir = 0;

	// Each room has a player so that it could be launched separately but we obviously need to allow only one player instance at a time
	global.plr_id = noone;

	// Tutorial
		global.plr_tutorial = false;
		enum PLAYER_TUTORIAL
		{
			PLACE,
			GRAB,
			MOVE,
			JUMP,
			FINISH
		}

		global.tutorial_number = PLAYER_TUTORIAL.FINISH;
		global.tutorial_move = {
			left : false,
			right : false,
			up : false,
			down : false
		}


	global.game_paused = false;
	
	global.at_room = undefined;
	global.room_info = [];


	global.dialogue_is_on_bottom = false;
	global.is_dialogue_on = false;

	global.plr_input_enabled = true;

	global.campfire_dialogue = false;
	global.is_night = false;

	global.transition_fade = 0;
	global.is_sunrise = false;
	global.is_windy = true;
	global.has_bird = false;
	global.bg_track = undefined;

	global.mute = false;

	global.is_speedrun_mode = false;
	global.speedrun_clock = 0;


	global.game_ending = false;
}
set_global_vars();
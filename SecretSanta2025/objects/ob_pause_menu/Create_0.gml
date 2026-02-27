
// - MESSAGE
	is_message = false;
	message_txt = "";

	message_x = room_width/2;
	message_y = room_height/2 + 32;
	message_yes_y = room_height/2 + 56;
	message_no_y = room_height/2 + 72;

	message_yes = -1;
	message_no = -1;

	set_message = function(_txt, _yes, _no)
	{
		is_message = true;
		message_txt = _txt;
		message_yes = _yes;
		message_no = _no;
	}

// -

// - BUTTON COORDINATES
	var _dif = 16;
	var _start = RES_H/2 + 64;
	var _y = _start;

	continue_x = RES_W/2;
	continue_y = _y;
	_y += _dif;

	fullscreen_x = RES_W/2;
	fullscreen_y = _y;
	_y += _dif;

	mute_x = RES_W/2;
	mute_y = _y;
	_y += _dif;

	menu_x = RES_W/2;
	menu_y = _y;
	_y += _dif;

	exit_x = RES_W/2;
	exit_y = _y;
	_y += _dif;
// -

// - BUTTON FUNCTIONS


	continue_func = function()
	{
		with ob_game unpause_game();
	}

	fullscreen_func = function()
	{
		window_set_fullscreen(!window_get_fullscreen());
	}

	mute_func = function()
	{
		global.mute = !global.mute;
		if global.mute 
		{
			audio_set_master_gain(0, 0);
		}
		else audio_set_master_gain(0, 1);
	}

	menu_func = function()
	{
		if global.bg_track != -1
		{
			audio_sound_gain(global.bg_track, 0, 2000);
		}
		instance_destroy(ob_plr);
		game_restart();
	}
	
	exit_func = function()
	{
		game_end();
	}

	btn_funcs = [continue_func, fullscreen_func, mute_func, menu_func, exit_func];
// -

// -

	selected = 0;
// -

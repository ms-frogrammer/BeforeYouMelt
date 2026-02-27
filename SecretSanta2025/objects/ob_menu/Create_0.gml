has_data = load_game() != -1;
speedrun_data = load_speedrun();

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
	var _start = room_height/2 + 40;
	var _y = _start;

	continue_x = room_width/2;
	continue_y = _y;
	_y += _dif;

	play_x = room_width/2;
	play_y = _y;
	_y += _dif;

	fullscreen_x = room_width/2;
	fullscreen_y = _y;
	_y += _dif;

	mute_x = room_width/2;
	mute_y = _y;
	_y += _dif;

	exit_x = room_width/2;
	exit_y = _y;
	_y += _dif;
// -

// - BUTTON FUNCTIONS
	play_func = function()
	{
		if has_data
		{
			selected = 0;
			set_message(
				"Your current progress will be lost. Are you sure?", 
				function()
				{
					//ob_room_handler.transition_to(rm_1, -1);
					instance_create_layer(0, 0, "Instances", ob_speedrun_menu);
					instance_destroy();
				}, 
				function()
				{
					is_message = false;
					selected = 1;
				}
			);
		}
		else 
		{
			ob_room_handler.transition_to(rm_1, -1);
		
		}
	}

	continue_func = function()
	{
		var _game_data = load_game();
		var _rm = rm_1;

		if _game_data != -1
		{
			_rm = asset_get_index(_game_data.room_name);
		}

		ob_room_handler.transition_to((_rm != -1) ? _rm : rm_1, -1);
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
	
	exit_func = function()
	{
		game_end();
	}

	btn_funcs = [continue_func, play_func, fullscreen_func, mute_func, exit_func];
// -

// -
	show_continue = has_data;
	selected = show_continue ? 0 : 1;
// -

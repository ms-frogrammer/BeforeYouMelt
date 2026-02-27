has_data = load_game() != -1;
best_time_data = load_speedrun();

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

	normal_x = room_width/2;
	normal_y = _y;
	_y += _dif;
	
	speedrun_x = room_width/2;
	speedrun_y = _y;
	_y += _dif;
// -


// - BUTTON FUNCTIONS
	speedrun_func = function()
	{
		global.is_speedrun_mode = true;
		global.speedrun_clock = 0;
		ob_room_handler.transition_to(rm_1, -1);
	}
	
	normal_func = function()
	{
		global.is_speedrun_mode = false;
		ob_room_handler.transition_to(rm_1, -1);
	}

	btn_funcs = [normal_func, speedrun_func];
// -

// -
	selected = 0;
// -

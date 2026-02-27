var _handlers = [ob_room_handler];

for(var i=0; i < array_length(_handlers); i++)
{
    instance_create_depth(0, 0, 0, _handlers[i]);
}


global.game_paused = false;

pause_game = function()
{
	global.game_paused = true;
	if !instance_exists(ob_pause_menu)
	{
		instance_create_depth(0, 0, -999, ob_pause_menu);
	}
	
	global.plr_input_enabled = false;
}

unpause_game = function()
{
	global.game_paused = false;
	global.plr_input_enabled = true;
	
	with ob_pause_menu instance_destroy();
}
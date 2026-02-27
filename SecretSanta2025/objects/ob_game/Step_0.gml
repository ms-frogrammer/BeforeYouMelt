var _pause_btn = input_check_pressed("pause");

if _pause_btn
{
	
	var _can_pause = !global.game_paused && global.plr_input_enabled && instance_exists(ob_plr);
	if _can_pause
	{
		pause_game();
		exit;
	}

	if global.game_paused 
	{

		unpause_game();
		exit;
	}
}
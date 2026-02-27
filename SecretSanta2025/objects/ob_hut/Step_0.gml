if back_to_menu
{
    if input_check_pressed("accept") || input_check_pressed("cancel")
    {
        game_restart();

        
    }
}
if !is_available exit;

var _msg = false;

// Make sure the player exists before looking to interact
if instance_exists(ob_plr)
{
    // Get info about player's placement
    var _plr_x, _plr_y, _nearby;

    with ob_plr 
    {
        _plr_x = x;
        _plr_y = y;
    }
	_nearby = _plr_x <= 254;
   
    // Let the player interact if they're nearby and standing on ground
    if _nearby 
    {
        _msg = true;

        if input_check_pressed("interact")
        {
           start();
        }
    }
    else _msg = false;
}


if _msg interact_cloud(216, 224, "[sp_interact_icons][#F9F5D2] to rest");
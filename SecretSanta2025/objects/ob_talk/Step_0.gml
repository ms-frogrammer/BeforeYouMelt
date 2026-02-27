
// Stop working if the player is already talking
if global.is_dialogue_on exit;

is_drawing_message = false;

// Make sure that talking is available through the handler
var _can_talk = ob_dialogue_handler.rtrn_can_talk();

if !_can_talk exit;

if talk_cooldown > 0
{
    talk_cooldown--;

    exit;
}


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
    
    _nearby = point_distance(x, y, _plr_x, _plr_y) <= interact_rad;
    
    // Let the player interact if they're nearby and standing on ground
    if _nearby 
    {
        is_drawing_message = true;

        if input_check_pressed("interact")
        {
            begin_talk();
        }
    }
    else is_drawing_message = false;
}


if is_drawing_message interact_cloud(x, y - 32, "[sp_interact_icons][#F9F5D2] to chat");
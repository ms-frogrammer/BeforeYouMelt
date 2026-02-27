y = ystart + sin(current_time/1000 * 3) * 6;
image_angle = sin(current_time/1000 * 6) * -7;


// Make sure the player exists before looking to interact
if instance_exists(ob_plr)
{
    // Get info about player's placement
    var _plr_x, _plr_y, _nearby;

    with ob_plr 
    {
        _plr_x = x;
        _plr_y = y - count_parts()*8;
    }
    
    _nearby = point_distance(x, ystart, _plr_x, _plr_y) <= 64;
    
    // Let the player interact if they're nearby and standing on ground
    if _nearby 
    {
        interact_cloud(x, y - 32, spr_string + "[#F9F5D2]" + text);
    }   
}

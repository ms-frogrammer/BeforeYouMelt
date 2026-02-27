#region TITLE
    var _float = sin(current_time/1000) * 4;

    var _color =  #e18d9d;
    var _scrib = scribble("[fnt_main]" + "[fa_center][fa_bottom]" + "select game mode:");
    _scrib.blend(_color, 1);
    _scrib.draw(room_width/2, room_height/2 - _float);
    
#endregion 


if is_message
{
    #region MESSAGE
        var _color = #e18d9d;
        var _scrib = scribble("[fnt_main]" + "[wave][fa_center][fa_middle]" + message_txt);
        _scrib.blend(_color, 1);
        _scrib.draw(message_x, message_y);
        
        var _color = (selected == 0) ? YELLOW : WHITE_WARM;
        var _scrib = scribble("[fnt_main]" + "[wave][fa_center][fa_middle]" + "yes");
        _scrib.blend(_color, 1);
        _scrib.draw(message_x, message_yes_y);

        var _color = (selected == 1) ? YELLOW : WHITE_WARM;
        var _scrib = scribble("[fnt_main]" + "[wave][fa_center][fa_middle]" + "no");
        _scrib.blend(_color, 1);
        _scrib.draw(message_x, message_no_y);
    #endregion
}
else 
{

    #region BUTTONS

        // Normal
            var _color = (selected == 0) ? YELLOW : WHITE_WARM;
            var _scrib = scribble("[fnt_main]" + "[wave][fa_center][fa_middle]" + "normal");
            _scrib.blend(_color, 1);
            _scrib.draw(normal_x, normal_y);

        // Speedrun
            var _color = (selected == 1) ? YELLOW : WHITE_WARM;
            var _scrib = scribble("[fnt_main]" + "[wave][fa_center][fa_middle]" + "speedrun");
            _scrib.blend(_color, 1);
            _scrib.draw(speedrun_x, speedrun_y);


    #endregion

}

#region SPEEDRUN TIME

    if !global.is_speedrun_mode
    {
        var _best_time_str = "-- m -- s -- ms"
        if best_time_data
        {
            _best_time_str = frames_to_string(best_time_data);
        }

        var _color = WHITE;

        var _scrib = scribble("[fnt_main]" + "[fa_center][fa_bottom]" + "BEST TIME:");
        _scrib.blend(_color, 1);
        _scrib.draw(room_width/2, 40 - _float);

        _color = YELLOW;

        _scrib = scribble("[fnt_main]" + "[wave][fa_center][fa_bottom]" + _best_time_str);
        _scrib.blend(_color, 1);
        _scrib.draw(room_width/2, 64 - _float);
    }
    
#endregion
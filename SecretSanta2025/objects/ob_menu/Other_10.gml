#region TITLE
    var _float = sin(current_time/1000) * 4;
        
    var _color = #e18d9d;
    var _scrib = scribble("[fnt_big]" + "[fa_center][fa_middle]" + "Before You Melt");
    _scrib.blend(_color, 1);
    _scrib.draw(room_width/2, room_height/2 - 80 - _float);


    var _color =  #e18d9d;
    var _scrib = scribble("[fnt_main]" + "[fa_left][fa_bottom]" + "a game by frogrammer");
    _scrib.blend(_color, 1);
    _scrib.draw(room_width/2 - 250, room_height/2 - 40 - _float);
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

        // Continue
            var _color = (selected == 0) ? YELLOW : WHITE_WARM;
            if !show_continue _color = #F3CFB5;
            var _scrib = scribble("[fnt_main]" + "[wave][fa_center][fa_middle]" + "continue");
            _scrib.blend(_color, show_continue ? 1 : 1);
            _scrib.draw(continue_x, continue_y);

        // New
        
            // if speedrun_data
            // {
            //     var _scrib = scribble("[fnt_main]" + "[fa_left][fa_middle]" + frames_to_string(speedrun_data));
            //     _scrib.blend(PINK, 1);
            //     _scrib.draw(play_x + 24, play_y);
            // }

            var _color = (selected == 1) ? YELLOW : WHITE_WARM;
            var _scrib = scribble("[fnt_main]" + "[wave][fa_center][fa_middle]" + "new");
            _scrib.blend(_color, 1);
            _scrib.draw(play_x, play_y);

        // Fullscreen
            var _color = (selected == 2) ? YELLOW : WHITE_WARM;
            var _scrib = scribble("[fnt_main]" + "[wave][fa_center][fa_middle]" + (window_get_fullscreen() ? "windowed" : "fullscreen"));
            _scrib.blend(_color, 1);
            _scrib.draw(fullscreen_x, fullscreen_y);

        // Mute
            var _color = (selected == 3) ? YELLOW : WHITE_WARM;
            var _scrib = scribble("[fnt_main]" + "[wave][fa_center][fa_middle]" + (global.mute ? "unmute" : "mute"));
            _scrib.blend(_color, 1);
            _scrib.draw(mute_x, mute_y);

        // Exit
            var _color = (selected == 4) ? YELLOW : WHITE_WARM;
            var _scrib = scribble("[fnt_main]" + "[wave][fa_center][fa_middle]" + "exit");
            _scrib.blend(_color, 1);
            _scrib.draw(exit_x, exit_y);

    #endregion

}
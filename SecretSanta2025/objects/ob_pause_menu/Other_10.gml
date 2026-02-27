if global.game_paused
{
    draw_set_color(DARK);
    draw_set_alpha(0.65);
        draw_rectangle(0, 0, RES_W, RES_H, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}


#region BUTTON PROMPTS
    var _prompts = ["[sp_w_icon]", "[sp_a_icon]", "[sp_s_icon]", "[sp_d_icon]", "[sp_jump_icons]", "[sp_grab_icons]", "[sp_place_icons]", "[sp_shift_icons]", "[sp_restart_icons]"];
    var _prompt_txt = ["up", "left", "down", "right", "jump",  "grab block", "place block", "stay on edge", "undo / hold to restart"];

    var _prompt_x = room_width/2 - 32;
    var _prompt_y = 64;
    var _prompt_yspace = 20;

    for(var i = 0; i < array_length(_prompts); i++)
    {
        var _scrib = scribble("[fnt_main]" + "[fa_left][fa_middle]" + _prompts[i] + " " + "[#f9f5d2]" + _prompt_txt[i]);
        _scrib.draw(_prompt_x, _prompt_y);
        _prompt_y += _prompt_yspace;
    }
#endregion

if is_message
{
    log(is_message)
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
            var _scrib = scribble("[fnt_main]" + "[wave][fa_center][fa_middle]" + "continue");
            _scrib.blend(_color, 1);
            _scrib.draw(continue_x, continue_y);

        // Fullscreen
            var _color = (selected == 1) ? YELLOW : WHITE_WARM;
            var _scrib = scribble("[fnt_main]" + "[wave][fa_center][fa_middle]" + (window_get_fullscreen() ? "windowed" : "fullscreen"));
            _scrib.blend(_color, 1);
            _scrib.draw(fullscreen_x, fullscreen_y);

        // Mute
            var _color = (selected == 2) ? YELLOW : WHITE_WARM;
            var _scrib = scribble("[fnt_main]" + "[wave][fa_center][fa_middle]" + (global.mute ? "unmute" : "mute"));
            _scrib.blend(_color, 1);
            _scrib.draw(mute_x, mute_y);

        // Menu
            var _color = (selected == 3) ? YELLOW : WHITE_WARM;
            var _scrib = scribble("[fnt_main]" + "[wave][fa_center][fa_middle]" + "menu");
            _scrib.blend(_color, 1);
            _scrib.draw(menu_x, menu_y);

        // Exit
            var _color = (selected == 4) ? YELLOW : WHITE_WARM;
            var _scrib = scribble("[fnt_main]" + "[wave][fa_center][fa_middle]" + "exit");
            _scrib.blend(_color, 1);
            _scrib.draw(exit_x, exit_y);

    #endregion

}

var _color = #e18d9d;
var _scrib = scribble("[fnt_main]" + "[wave][fa_center][fa_middle]" + "* game progress is saved.");
_scrib.blend(_color, 1);
_scrib.draw(RES_W/2, RES_H - 32);
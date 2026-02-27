DRAW_SELF

if show_puddle
{
    draw_sprite_ext(puddle_beanie ? sp_puddle_beanie : sp_puddle, 0, 206, 278, -1, 1, 0, c_white, 1);
}

if show_man
{
    if is_walking
    {
        

        if !man_reached_beanie
        {
            man_x = max(man_x - 1, man_left_x);

            if man_x <= man_left_x
            {
                man_anim.play(sp_man_idle, false);
                man_reached_beanie = true;
                reached_puddle();
            }
            
            if man_anim.spr == sp_man_transition && man_anim.img >= 1
            {
                man_anim.play(sp_man_walk, false);
            }
        }
        else 
        {
            if man_go_back
            {
                man_x = min(man_x + 1, 364);
                if man_x >= 364 
                {
                    finish();
                }
            }
        }
        
    }

    man_anim.step();
    draw_sprite_ext(man_anim.spr, man_anim.img, man_x, man_y, man_go_back ? 1 : -1, 1, 0, c_white, 1);
}

if show_title
{
    title_alpha = 1;
    
    var _color = #e18d9d;
    var _font = small_title ? "[fnt_main]" : "[fnt_big]";
    var _scrib = scribble(_font + "[fa_center][fa_middle]" + title_text);
    _scrib.blend(_color, title_alpha);
    _scrib.draw(room_width/2, room_height/2 - 80);
}

if speedrun_title
{
    #region BEST TIME
        if best_time_data
        {
            if is_new_best
            {
                var _color = PINK_DARK;

                var _scrib = scribble("[fnt_main]" + "[wave][fa_center][fa_bottom]" + "new best!");
                _scrib.blend(_color, 1);
                _scrib.draw(room_width/2, room_height/2 - 100);
            }
            
            var _color = WHITE;

            var _scrib = scribble("[fnt_main]" + "[fa_center][fa_bottom]" + "BEST TIME:");
            _scrib.blend(_color, 1);
            _scrib.draw(room_width/2, room_height/2 - 60);

            _color = YELLOW;

            var _best_time_str = frames_to_string(best_time_data);
            _scrib = scribble("[fnt_main]" + "[wave][fa_center][fa_bottom]" + _best_time_str);
            _scrib.blend(_color, 1);
            _scrib.draw(room_width/2, room_height/2 - 40);
        }
    #endregion
}
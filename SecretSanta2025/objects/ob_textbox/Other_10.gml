
var _cam_x = camera_get_view_x(VIEW);
var _cam_y = camera_get_view_y(VIEW);
var _cam_w = camera_get_view_width(VIEW);
var _cam_h = camera_get_view_height(VIEW);

var _textbox_plus_portrait_width = textbox_width + portrait_width;
var _border_x = (_cam_w - _textbox_plus_portrait_width)/2

var _textbox_x = _cam_x + _border_x;
var _textbox_y = _cam_y + textbox_offsets_y[is_on_bottom];

draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_font(fnt_main);

// - DIALOGUE BOX DIMENSIONS
    var _box_spr = sp_textbox;
    var _box_spr_w = sprite_get_width(_box_spr);
    var _box_spr_h = sprite_get_height(_box_spr);
// -

// - PORTRAIT DIMENSIONS
    //var _portrait_bg_spr = sp_dialogue_portrait_bg;
    //var _portrait_spr_w = sprite_get_width(_portrait_bg_spr);
    //var _portrait_spr_h = sprite_get_height(_portrait_bg_spr);
    //var _portrait_scale_x = portrait_width/_portrait_spr_w;
    //var _portrait_scale_y = portrait_height/_portrait_spr_h;
// -

// Do a one-time setup
#region SETUP
    if !setup_done
    {
        setup_done = true;


        // Loop through the pages
        for(var p = 0; p < page_number; p++)
        {
            // Find how many characters are on each page
            // Store the number in the "text_length" array
            text_length[p] = string_length(text[p]);

            text_x_offset[p] = _border_x;

            
            
            // Setting individual characters and finding where the lines of text should break
            for(var c = 0; c < text_length[p]; c++)
            {
                var _char_pos = c+1;

                // Store individual characters in "char" array]
                char[c, p] = string_char_at(text[p], _char_pos)
                
                // Get current width of thr line
                var _txt_up_to_char = string_copy(text[p], 1, _char_pos);
                var _current_txt_w = string_width(_txt_up_to_char) - string_width(char[c, p]);

                // Get the last free sace
                if char[c, p] == " " 
                {
                    last_free_space = _char_pos + 1;
                }

            
                var _number_of_lines = line_break_num[p] + 1;
                var _line_width = get_line_width(_number_of_lines);
                // Get the line breaks
                if _current_txt_w - line_break_offset[p] > _line_width
                {
                    line_break_pos[ line_break_num[p], p] = last_free_space;
                    line_break_num[p] ++;
                    var _txt_up_to_last_space = string_copy(text[p], 1, last_free_space);
                    var _last_free_space_string = string_char_at(text[p], last_free_space);
                    line_break_offset[p] = string_width(_txt_up_to_last_space) - string_width(_last_free_space_string);
                }
            }
            // Getting each character's coordinates
            for(var c = 0; c < text_length[p]; c++)
            {
                var _char_pos = c+1;

                // Get the padding
                var _number_of_lines = line_break_num[p] + 1;

                var _padding_left = paddings[_number_of_lines].left;
                var _padding_top =  paddings[_number_of_lines].top;

                var _txt_x = _textbox_x + _padding_left - _cam_x;
                var _txt_y = _textbox_y + _padding_top - _cam_y;

                // Get current width of the line
                var _txt_up_to_char = string_copy(text[p], 1, _char_pos);
                var _current_txt_w = string_width(_txt_up_to_char) - string_width(char[c,p]);
                var _txt_line = 0;
                
                // Compensate for string breaks
                for(var lb = 0; lb < line_break_num[p]; lb++)
                {
                    if _char_pos >= line_break_pos[lb, p]
                    {
                        var _str_copy = string_copy(text[p], line_break_pos[lb, p], _char_pos - line_break_pos[lb, p]);
                        _current_txt_w = string_width(_str_copy);
                        
                        _txt_line = lb + 1;
                    }
                }

                // Compensate for string breaks
                for(var lb = 0; lb < line_break_num[p]; lb++)
                {
                    // If the current looping character is after a line break
                    if _char_pos >= line_break_pos[lb, p]
                    {
                        var _str_copy = string_copy(text[p], line_break_pos[lb, p], _char_pos - line_break_pos[lb, p]);
                        _current_txt_w = string_width(_str_copy);
                        
                        // Record the "line" this character should be on
                        _txt_line = lb + 1; // + 1 since lb starts at 0
                        
                    }
                }
                // Add to the X and Y coordinates based on the new info
                char_x[c, p] = _txt_x + _current_txt_w;
                char_y[c, p] = _txt_y + _txt_line*line_sep;
            }

        }

        if ignore_opening_anim
        {
            completed_open_anim();
        }

    }
#endregion

// Enter the screen
#region OPEN ANIM
    if !is_open
    {
        if pop_in_time < pop_in_dur
        {
            pop_in_time++;
        }
        else 
        {
            if scale_time < scale_dur
            {
                scale_time++;
            }
            else 
            {
                if fade_in_time < fade_in_dur
                {
                    fade_in_time++;
                }
                else 
                {
                    if portrait_fade_in_time < portrait_fade_in_dur
                    {
                        portrait_fade_in_time++;
                    }
                    else 
                    {
                        // Proceed with typing the dialogue
                        completed_open_anim();
                    }
                }
            }
        }


        // Offset the textbox's Y for the pop in effect
        if is_on_bottom
        {
            _textbox_y += (_cam_h - textbox_offsets_y[is_on_bottom]) * AnimcurveTween(1, 0, acBackInOut, pop_in_time/pop_in_dur);
        }
        else 
        {
            _textbox_y -= textbox_height * AnimcurveTween(1, 0, acBackInOut, pop_in_time/pop_in_dur);
        }


        // - DRAW THE TEXTBOX
            var _entire_width = textbox_width + portrait_width - 1;

            var _start_width = 4;
            var _current_width = _start_width + AnimcurveTween(0, _entire_width-_start_width, acBackInOut, scale_time/scale_dur);

            var _x = _textbox_x + _entire_width/2 - _current_width/2;
            var _y = _textbox_y;
            var _scale_x = round(_current_width/_box_spr_w);
            var _scale_y = round(textbox_height/_box_spr_h);

            draw_set_halign(fa_middle);

            draw_sprite_ext(_box_spr, 0, round(_x), round(_y), _scale_x, _scale_y, 0, c_white, 1);
        
            draw_set_halign(fa_left);
        // -

        // - DRAW THE PORTRAIT
			/*
            if fade_in_time > 0 
            {
                var _alpha = fade_in_time/fade_in_dur;

                var _px = _textbox_x + textbox_width - 1;
                var _py = _textbox_y;
            
                // Draw portrait's background
                draw_sprite_ext(_portrait_bg_spr, 0, _px, _py, _portrait_scale_x, _portrait_scale_y, 0, c_white, _alpha);
                
                var _spr = portrait_spr[page];
                if _spr
                {
                    // Draw the silhouette
                    draw_sprite_ext(_spr, 0, _px, _py, 1, 1, 0, c_white, _alpha);

                    // Draw the portrait
                    draw_sprite_ext(_spr, 1, _px, _py, 1, 1, 0, c_white, portrait_fade_in_time/portrait_fade_in_dur);
                }
            
            }
            */
        // -
        exit;
    }
#endregion 

// Leave the screen
#region CLOSE ANIM
    if is_closing 
    {
        if portrait_fade_in_time > 0
        {
            portrait_fade_in_time-=2;
        }
        else 
        {
            if fade_in_time > 0
            {
                fade_in_time-=2;
            }
            else 
            {
                if scale_time > 0
                {
                    scale_time--;
                }
                else 
                {
                    close_fully();
                }
            }
        }

        // Offset the Y for the pop out effect
        if is_on_bottom
        {
            _textbox_y += (_cam_h - textbox_offsets_y[is_on_bottom]) * AnimcurveTween(1, 0, acBackInOut, pop_in_time/pop_in_dur);
        }
        else 
        {
            _textbox_y -= textbox_height * AnimcurveTween(1, 0, acBackInOut, pop_in_time/pop_in_dur);
        }


        // - DRAW THE TEXTBOX
            var _full_width = textbox_width + portrait_width - 1;
            var _start_width = 0;
            var _current_width = _start_width + AnimcurveTween(0, _full_width-_start_width, acLinear, scale_time/scale_dur);
            var _scale_x = round(_current_width/_box_spr_w);
            var _scale_y = round(textbox_height/_box_spr_h);
            draw_set_halign(fa_middle);

            draw_sprite_ext(_box_spr, 0, round(_textbox_x + _full_width/2 - _current_width/2), round(_textbox_y), _scale_x, _scale_y, 0, c_white, 1);
        
            draw_set_halign(fa_left);
        // -

        // - DRAW THE PORTRAIT
			/*
            if fade_in_time > 0 
            {
                var _px = _textbox_x + textbox_width - 1;
                var _py = _textbox_y;
                draw_sprite_ext(_portrait_bg_spr, 0, _px, _py, _portrait_scale_x, _portrait_scale_y, 0, c_white, fade_in_time/fade_in_dur);
                
                var _spr = portrait_spr[page];
                if _spr
                {
                    // Draw the silhouette
                    draw_sprite_ext(_spr, 0, _px, _py, 1, 1, 0, c_white, fade_in_time/fade_in_dur);
                    
                    // Draw the portrait
                    draw_sprite_ext(_spr, 1, _px, _py, 1, 1, 0, c_white, portrait_fade_in_time/portrait_fade_in_dur);
                }
            
            }
			*/
            
        // -
        exit;
    }
#endregion

// Type out the text, one character at a time
#region TYPING THE TEXT
    if text_pause_timer <= 0 
    {
        if draw_char < text_length[page]
        {
            draw_char += text_spd;
            draw_char = clamp(draw_char, 0, text_length[page]);
            var _check_char = string_char_at(text[page], draw_char);

            if _check_char == "." || _check_char == "," || _check_char == "!" || _check_char == "?"
            {
                text_pause_timer = text_pause_dur;
                
                snd_play_rndpitch(sfx_talk_blip_1);
            }
            else
            {
                if snd_count <= snd_delay
                {
                    snd_count++;
                }
                else 
                {
                    snd_count = 0;
                    snd_play_rndpitch(sfx_talk_blip_1);
                    snd_play_rndpitch(snd[page]);
                }
            }
        }
    }
    else text_pause_timer--;
#endregion

// Flip through pages if skipped or done typing
#region FLIP THROUGH PAGES
    if accept_key 
    {
        // If the typing is done
        if draw_char == text_length[page]
        {
            // Next page
            if page < page_number - 1
            {
                page++;

                // If player pressed "shift", load the next page as already complete
                if skip_key
                {
                    draw_char = text_length[page];
                }
                // If the player only pressed "space", load the next page from the start
                else draw_char = 0;
            }
            // Close the textbox (play the closing animation or spawn options)
            else
            {
                close_textbox();
            }
        }
        // If not done typing
        else 
        {
            // Get to the last character (type-out)
            draw_char = text_length[page];
        }
    }
#endregion

// Draw the textbox sprite (bg)
#region DRAW TEXBOX

    var _box_spr = sp_textbox;
    var _spr_w = sprite_get_width(_box_spr);
    var _spr_h = sprite_get_height(_box_spr);
    var _scale_x = round(textbox_width/_spr_w);
    var _scale_y = round(textbox_height/_spr_h)
    draw_sprite_ext(_box_spr, 0, round(_textbox_x), round(_textbox_y), _scale_x, _scale_y, 0, c_white, 1);
	draw_text_scribble(round(_textbox_x) + 16 * _scale_x, round(_textbox_y) + 16 *_scale_y + 4 + sin(current_time/1000) * 4, "[fa_right][fa_top][sp_talk_icons]");
#endregion

// Draw 'proceed' button once done typing
#region DRAW 'NEXT' BUTTON
    // Draw "next" button
    if draw_char == text_length[page]
    {
        draw_sprite(sp_textbox_next, 0, _textbox_x + textbox_width - 12, _textbox_y + textbox_height - 6);
    }
#endregion

// Draw speaker's portrait if there is one
#region DRAW PORTRAIT
	/*
    var _px = _textbox_x + textbox_width - 1;
    var _py = _textbox_y;
    draw_sprite_ext(_portrait_bg_spr, 0, _px, _py, _portrait_scale_x, _portrait_scale_y, 0, c_white, 1);
    
    var _spr = portrait_spr[page];
    if _spr
    {
        draw_sprite(_spr, 1, _px, _py);
    }
	*/
#endregion


// Draw speaker's name
#region DRAW CHARACTER NAME
	/*
    draw_set_font(fnt_small);
    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
	
	var _px = _textbox_x + textbox_width - 1;
    var _py = _textbox_y;
    draw_text(_px + portrait_width, _py + 2, current_name);

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    */
#endregion

// Draw and select options if there are any at the end of the dialogue
#region OPTIONS
    if draw_char == text_length[page] && page == page_number - 1
    {
        // Option selection
        
        if dir_key != 0 
        {
            snd_play_rndpitch(sfx_talk_blip_1);
        }

        option_pos += dir_key;
        option_pos = wrap_value(option_pos, 0, option_number - 1);
        
        // Draw the options
        var _op_space = 25;
        var _op_bord = 13;
        for(var _op = 0; _op < option_number; _op++)
        {
            // The option box
            var _box_spr = sp_textbox;
            var _spr_w = sprite_get_width(_box_spr);
            var _spr_h = sprite_get_height(_box_spr);
            var _o_w = string_width(option[_op]) + _op_bord * 2;
            var _x = _textbox_x;
            if is_on_bottom
            {
                var _y = _textbox_y - (_op_space+1)*option_number + (_op_space+1)*_op;
            }
            else 
            {
                var _y = _textbox_y + textbox_height + _op_space*_op + 1;
            }

            // The arrow
            var _is_selected = option_pos == _op;
            if _is_selected
            {
                _x += 12;
                //draw_sprite(sp_UIarrow_right, 0, _textbox_x + 8, _y + 8);
            }
            
           
            draw_sprite_ext(_box_spr, 0, round(_x), round(_y), round(_o_w/_spr_w), (_op_space)/_spr_h, 0, c_white, 1);
            
            // The option text
            draw_set_color(WHITE_WARM);
            draw_text(_x - 8 + _op_bord, _y + 3, option[_op]);
        }
    }

#endregion

// Draw the text itself
#region DRAW TEXT


    var _is_reading_tag = false;
    var _tag = "";
    var _applied_tags = [];

    for(var c = 0; c < draw_char; c++)
    {
        var _char = char[c, page];
        // - FLOATING TEXT
            var _float_y = 0, _dir_spd = -6;
            var _float_spd = float_spd[c, page];
            var _float_range = float_range[c, page];

            if _float_spd > 0
            {
                float_dir[c, page] += _dir_spd * _float_spd;
                _float_y = dsin(float_dir[c, page]) * _float_range;
            }
        // -

        // - SHAKE
            var _shake_x = 0;
            var _shake_y = 0;
            
            if shake_text[c, page]
            {
                shake_timer[c, page]--;
                if shake_timer[c, page] <= 3
                {
                    shake_timer[c, page] = irandom_range(4, 8);
                    shake_dir[c, page] = irandom(360);

                    _shake_x = lengthdir_x(1, shake_dir[c, page]);
                    _shake_y = lengthdir_y(1, shake_dir[c, page]);
                }
            }
        // -

        // - APPLY COLOR
            textbox_set_color(col[c, page]);
        // -

        var _cx = char_x[c, page] + _cam_x + _shake_x;
        var _cy = char_y[c, page] + _cam_y + _shake_y + _float_y;
        draw_text(_cx, _cy, _char);
    }


#endregion

draw_set_color(c_white);
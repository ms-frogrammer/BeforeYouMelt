#region OPEN/CLOSE ANIMATIONs
    ignore_opening_anim = false;

    pop_in_time = 0;
    pop_in_dur = 30;
    scale_time = 0;
    scale_dur = 30;
    fade_in_time = 0;
    fade_in_dur = 16;
    portrait_fade_in_time = 0;
    portrait_fade_in_dur = 16;

    completed_open_anim = function()
    {
        pop_in_time = pop_in_dur;
        scale_time = scale_dur;
        fade_in_time = fade_in_dur;
        portrait_fade_in_time = portrait_fade_in_dur;

        is_open = true;
    }
#endregion

#region TEXTBOX PARAMETER
    depth = -999;

    is_open = false;
    is_closing = false;

    textbox_width = 400;
    textbox_height = 64;

    current_portrait = undefined;
    portrait_spr = [];
    portrait_width = 0; // 50
    portrait_height = textbox_height;

    current_name = "???";

    is_on_bottom = false;
    
    var _margin = 64;
    textbox_offsets_y = [_margin, 420 - _margin - textbox_height];

    line_number_limit = 3;
    line_sep = 12;

    // - PADDING
        paddings = array_create(line_number_limit);

        // Padding for 1 line of text
        paddings[1] =
        {
            top :       24,
            bottom :    24,
            left :      8,
            right :     12,
        }
        // Padding for 2 lines of text
        paddings[2] =
        {
            top :       16,
            bottom :    16,
            left :      8,
            right :     12,
        }
        // Padding for 3 lines of text
        paddings[3] =
        {
            top :       8,
            bottom :    8,
            left :      8,
            right :     12,
        }
    // -

    get_line_width = function(_line_number)
    {
        return textbox_width - (paddings[_line_number].left + paddings[_line_number].right); 
    }

    
#endregion

#region TEXT
    page = 0;
    page_number = 0;
    text = [];
    text_length = [];

    char[0, 0] = "";
    char_x[0, 0] = 0;
    char_y[0, 0] = 0;

    draw_char = 0;
    text_spd = 1;
    text_color = c_white;

    setup_done = false;
#endregion

#region OPTIONS
    option[0] = "";
    option_link_id[0] = -1;
    option_pos = 0;
    option_number = 0;
    
#endregion

close_textbox = function()
{
    var _has_options = option_number > 0;
    if _has_options
    {
        with textbox_create(option_link_id[option_pos])
        {
            // Ignore the opening animation because this textbox is a continuation of the option
            ignore_opening_anim = true;
        }

        // Destroy without the closing animation because the next box will spawn on top
        instance_destroy();
        
    }
    else 
    {
        // Play the closing animation and eventually get destroyed
        is_closing = true;
    }
}


/// @desc Called after the closing animation is complete and there are no other options to continue the dialogue
close_fully = function()
{
    instance_destroy();
    event_publish(EV_TEXTBOX_END);
}

#region SOUND
  
    snd_delay = 4;
    snd_count = snd_delay;
#endregion

#region EFFECTS
    textbox_set_default();
    last_free_space = 0;
    text_pause_timer = 0;
    text_pause_dur = 16;
#endregion

#region INPUT
	accept_key = false; // Accept the option or type out 
	skip_key = false; // Type out fully (current or next paragraphs)
    dir_key = 0; // Key to select between options
#endregion

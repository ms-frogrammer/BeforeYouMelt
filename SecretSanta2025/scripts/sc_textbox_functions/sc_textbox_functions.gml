function textbox_set_default()
{
    line_break_pos[0, page_number] = 999;
    line_break_num[page_number] = 0;
    line_break_offset[page_number] = 0;

    for(var c = 0; c < 500; c++)
    {
        col[c, page_number] = WHITE_WARM;
		
        var _degrees_away = 20; // How many degrees chacters are away from each other
        float_dir[c, page_number]  = c*20;
        float_spd[c, page_number] = 0;
        float_range[c, page_number] = 1;
        
        shake_text[c, page_number] = false;
        shake_dir[c, page_number] = irandom(360);
        shake_timer[c, page_number] = irandom(4);
    }
    

    character_name[page_number] = current_name;
    portrait_spr[page_number] = current_portrait;
    portrait_slide[page_number] = 1;
    snd[page_number] = sfx_voice_1;
}


/// @param First_Character
/// @param Last_Character
/// @param Color
function textbox_color(_start, _end, _color)
{
    for(var c = _start; c <= _end; c++)
    {
        col[c, page_number - 1] = _color;
    }
}

/// @param First_Character
/// @param Last_Character
/// @param Float_Spd
/// @param Float_Range
function textbox_float(_start, _end, _spd = 1, _range = 1)
{
    for(var c = _start; c <= _end; c++)
    {
        float_spd[c, page_number - 1] = _spd;
        float_range[c, page_number - 1] = _range;
    }
}


/// @param First_Character
/// @param Last_Character
function textbox_shake(_start, _end)
{
    for(var c = _start; c <= _end; c++)
    {
        shake_text[c, page_number - 1] = true;
    }
}

function textbox_set_portrait(_spr)
{
    current_portrait = _spr
}

function textbox_set_character_name(_name)
{
    current_name = _name;
}

function textbox_set_speaker(_name)
{
    //switch(_name)
    //{
        //case "Frog":
        //    textbox_set_portrait(sp_very_handsome_frog);
        //    textbox_set_character_name(_name);
        //    break;
        // case "Goggles":
        //    textbox_set_portrait(sp_goggles);
        //    textbox_set_character_name(_name);
        //    break;
    //}
}
function textbox_create(_text_id)
{
	with instance_create_depth(0, 0, -999, ob_textbox)
	{
		get_dialogue_text_with_id(_text_id);

        is_on_bottom = global.dialogue_is_on_bottom;
        
		return id;
	}
}

function textbox_set_color(_color)
{
    text_color = _color;
    draw_set_color(_color);
}


function textbox_set_voice(_snd)
{
    snd[max(0, page_number-1)] = _snd;
}

function new_dialogue_txt(_text)
{
    textbox_set_default();

    text[page_number] = _text;

    portrait_spr[page_number] = current_portrait;
    character_name[page_number] = current_name;
   // snd[page_number] = sfx_voice_1;

    page_number++;
}

function add_dialogue_txt_many(_text)
{
    for(var i = 0; i < argument_count; i++)
    {
        new_dialogue_txt(argument[i]);
    }
}

function dialogue_option(_option, _link_id)
{
    option[option_number] = _option;
    option_link_id[option_number] = _link_id;

    option_number++;
}

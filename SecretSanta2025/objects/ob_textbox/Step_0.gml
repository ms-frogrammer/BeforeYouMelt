
if !is_open || is_closing exit;

accept_key = input_check_pressed("accept");
skip_key = false;
dir_key = input_check_opposing_pressed("up", "down");

if accept_key
{
    snd_play(sfx_talk_blip_1);  
}


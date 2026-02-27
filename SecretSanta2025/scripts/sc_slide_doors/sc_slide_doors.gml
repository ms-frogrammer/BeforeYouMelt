function slide_door_make_sound(_is_sliding, _has_signal)
{
        
    if _is_sliding
    {
        var _target_sound = _has_signal ? sfx_slide_door_open : sfx_slide_door_close;
        if snd == -1
        {
            snd = snd_play(_target_sound, true);
        }
        else if audio_sound_get_asset(snd) != _target_sound
        {
            audio_stop_sound(snd);
            snd = snd_play(_target_sound, true);
        }
    }
    else 
    {
        if snd != -1 
        {
            audio_stop_sound(snd);
            snd = -1;
        }
    }

}
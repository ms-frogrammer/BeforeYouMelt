#macro _og_game_restart game_restart
#macro game_restart _game_restart

function _game_restart()
{
    audio_stop_all();
    set_global_vars();
    room_goto(rm_menu);
}
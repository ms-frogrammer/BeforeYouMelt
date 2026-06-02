create_each_room = [ob_dialogue_handler, ob_interact_handler, ob_bg_handler, ob_snow_layer, ob_tower_layer];

front = noone;
back = noone;

is_transitioning = false;
is_reloading = false;
to_room = noone;
exit_id = -1;

is_fading_in = false;
fade_spd = 1/40; //1/40

restart_held = 0;

ice_snd = noone;

old_track = noone;

transition_to = function(_room, _id)
{
	is_transitioning = true;
	is_reloading = false;
	to_room = _room;
    exit_id = _id;

	is_fading_in = true;
}

reload_room = function()
{
	
	is_transitioning = true;
	is_reloading = true;

	is_fading_in = true;
}

stop_old_track = function()
{
	audio_stop_sound(old_track);
}
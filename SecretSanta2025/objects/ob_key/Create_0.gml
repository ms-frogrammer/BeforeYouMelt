
event_inherited();

get_used = function()
{
	vfx_create_cloud(x, y, sp_effect_circle, WHITE, 4, 1, 2, 0.05, -30, 0.5, 0.75, -1/30, 30, false, 1/120);
	vfx_preset_frozen_cloud(x, y, c_white);
	snd_play_rndpitch(sfx_key_unlock, false);
	instance_destroy();
}